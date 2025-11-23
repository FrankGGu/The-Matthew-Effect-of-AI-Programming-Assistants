(define (minimum-moves target blocked)
  (define n (add1 (max (map car target)) (max (map cdr target))))
  (define blocked-set (set))
  (for ([b blocked]) (set-add! blocked-set b))

  (define (valid? pos dir)
    (match dir
      [0 (and (<= 0 (car pos)) (< (car pos) n - 1) (<= 0 (cdr pos)) (< (cdr pos) n)
               (not (set-member? blocked-set (list (car pos) (cdr pos))))
               (not (set-member? blocked-set (list (add1 (car pos)) (cdr pos)))))]
      [1 (and (<= 0 (car pos)) (< (car pos) n) (<= 0 (cdr pos)) (< (cdr pos) n - 1)
               (not (set-member? blocked-set (list (car pos) (cdr pos))))
               (not (set-member? blocked-set (list (car pos) (add1 (cdr pos))))))]))

  (define (valid-move? pos dir new-pos)
    (match dir
      [0 (match new-pos
           ['forward (and (valid? new-pos dir) (not (set-member? blocked-set (list (add2 (car pos)) (cdr pos)))))]
           ['backward (and (valid? new-pos dir) (not (set-member? blocked-set (list (sub1 (car pos)) (cdr pos)))))]
           ['rotate-cw (and (valid? new-pos 1) (not (set-member? blocked-set (list (car pos) (add1 (cdr pos))))))]
           ['rotate-ccw (and (valid? new-pos 1) (not (set-member? blocked-set (list (add1 (car pos)) (sub1 (cdr pos))))))])]
      [1 (match new-pos
           ['forward (and (valid? new-pos dir) (not (set-member? blocked-set (list (car pos) (add2 (cdr pos))))))]
           ['backward (and (valid? new-pos dir) (not (set-member? blocked-set (list (car pos) (sub1 (cdr pos))))))]
           ['rotate-cw (and (valid? new-pos 0) (not (set-member? blocked-set (list (add1 (car pos)) (cdr pos)))))]
           ['rotate-ccw (and (valid? new-pos 0) (not (set-member? blocked-set (list (sub1 (car pos)) (add1 (cdr pos))))))])]))

  (define q (make-queue))
  (queue-enqueue! q (list (list 0 0) 0 0)) ; (pos dir moves)
  (define visited (make-hash))
  (hash-set! visited (list (list 0 0) 0) #t)

  (define (get-neighbors pos dir)
    (define neighbors '())
    (define forward-pos (match dir [0 (list (add1 (car pos)) (cdr pos))] [1 (list (car pos) (add1 (cdr pos)))]))
    (define backward-pos (match dir [0 (list (sub1 (car pos)) (cdr pos))] [1 (list (car pos) (sub1 (cdr pos)))]))
    (define rotate-cw-pos (list (car pos) (cdr pos)))
    (define rotate-ccw-pos (list (car pos) (cdr pos)))

    (when (and (valid-move? pos dir 'forward forward-pos)) (set! neighbors (cons (list forward-pos dir) neighbors)))
    (when (and (valid-move? pos dir 'backward backward-pos)) (set! neighbors (cons (list backward-pos dir) neighbors)))
    (when (and (valid-move? pos dir 'rotate-cw rotate-cw-pos)) (set! neighbors (cons (list pos (if (= dir 0) 1 0)) neighbors)))
    (when (and (valid-move? pos dir 'rotate-ccw rotate-ccw-pos)) (set! neighbors (cons (list pos (if (= dir 0) 1 0)) neighbors)))
    neighbors)

  (let loop ()
    (if (queue-empty? q)
        -1
        (let ([curr (queue-dequeue! q)])
          (let ([pos (car curr)]
                [dir (cadr curr)]
                [moves (caddr curr)])
            (if (and (= (car pos) (car target)) (= (cdr pos) (cdr target)) (= dir 0))
                moves
                (let ([neighbors (get-neighbors pos dir)])
                  (for ([neighbor neighbors])
                    (unless (hash-has-key? visited neighbor)
                      (hash-set! visited neighbor #t)
                      (queue-enqueue! q (list (car neighbor) (cadr neighbor) (add1 moves)))))
                  (loop)))))))