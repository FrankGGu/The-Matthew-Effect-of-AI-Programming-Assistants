(define (minimum-time grid)
  (define rows (length grid))
  (define cols (length (car grid)))

  (define (valid? row col)
    (and (>= row 0) (< row rows) (>= col 0) (< col cols)))

  (define (solve)
    (define dist (make-vector (* rows cols) #inf))
    (vector-set! dist 0 0)
    (define pq (list (cons 0 (cons 0 0)))) ; (distance . (row . col))

    (define (push q cost row col)
      (if (valid? row col)
          (let ((idx (+ (* row cols) col)))
            (if (> (vector-ref dist idx) cost)
                (begin
                  (vector-set! dist idx cost)
                  (sorted-insert q (cons cost (cons row col)))))
            q)
          q))

    (define (sorted-insert q item)
      (cond
        ((null? q) (list item))
        ((<= (car item) (car (car q))) (cons item q))
        (else (cons (car q) (sorted-insert (cdr q) item)))))

    (define (pq-empty? q) (null? q))
    (define (pq-pop! q) (values (car q) (cdr q)))

    (let loop ((q pq))
      (if (pq-empty? q)
          (vector-ref dist (- (* rows cols) 1))
          (let-values (((curr-dist curr-pos) (pq-pop! q)))
            (let ((curr-row (car curr-pos)) (curr-col (cdr curr-pos)))
              (if (> curr-dist (vector-ref dist (+ (* curr-row cols) curr-col)))
                  (loop q)
                  (let* ((new-q (push q (+ curr-dist 1) (+ curr-row 1) curr-col))
                         (new-q (push new-q (+ curr-dist 1) (- curr-row 1) curr-col))
                         (new-q (push new-q (+ curr-dist 1) curr-row (+ curr-col 1)))
                         (new-q (push new-q (+ curr-dist 1) curr-row (- curr-col 1))))
                    (loop new-q))))))))

  (if (> (vector-ref (car grid) 1) 1)
      -1
      (if (> (vector-ref (car (car grid)) 1) 1)
          -1
          (let ((result (solve)))
            (if (= result #inf)
                -1
                result)))))