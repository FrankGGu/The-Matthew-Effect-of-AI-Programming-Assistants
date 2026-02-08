(define (nearest-exit maze entrance)
  (define m (length maze))
  (define n (length (car maze)))
  (define q (queue))
  (define visited (make-vector m (make-vector n #f)))

  (define (is-valid? r c)
    (and (>= r 0) (< r m) (>= c 0) (< c n) (equal? (list-ref (list-ref maze r) c) #\.)))

  (define (is-exit? r c)
    (or (= r 0) (= r (- m 1)) (= c 0) (= c (- n 1))))

  (queue-enqueue! q (list (car entrance) (cadr entrance) 0))
  (vector-set! (vector-ref visited (car entrance)) (cadr entrance) #t)

  (let loop ()
    (cond
      [(queue-empty? q) -1]
      [else
       (let* ([curr (queue-dequeue! q)]
              [r (car curr)]
              [c (cadr curr)]
              [dist (caddr curr)])
         (cond
           [(and (not (equal? (list r c) entrance)) (is-exit? r c)) dist]
           [else
            (define neighbors
              (list (list (- r 1) c) (list (+ r 1) c) (list r (- c 1)) (list r (+ c 1))))
            (for-each (lambda (neighbor)
                        (let ([nr (car neighbor)]
                              [nc (cadr neighbor)])
                          (when (and (is-valid? nr nc) (not (vector-ref (vector-ref visited nr) nc)))
                            (queue-enqueue! q (list nr nc (+ dist 1)))
                            (vector-set! (vector-ref visited nr) nc #t))))
                      neighbors)
            (loop)]))]))
  )