(define (second-minimum n edges time change)
  (define graph (make-vector (+ n 1) '()))
  (for-each (lambda (edge)
              (let ((u (car edge)) (v (cadr edge)))
                (vector-set! graph u (cons v (vector-ref graph u)))
                (vector-set! graph v (cons u (vector-ref graph v)))))
            edges)

  (define dist (make-vector (+ n 1) (list +inf.0 +inf.0)))
  (vector-set! dist 1 (list 0 +inf.0))

  (define q (list 1))

  (define (bfs)
    (if (null? q)
        #f
        (let ((u (car q)))
          (set! q (cdr q))
          (for-each (lambda (v)
                      (let ((curr-dist (vector-ref dist v)))
                        (define new-time (+ (car (vector-ref dist u)) time))
                        (if (< new-time (car curr-dist))
                            (begin
                              (vector-set! dist v (list new-time (car curr-dist)))
                              (set! q (append q (list v))))
                            (if (and (> new-time (car curr-dist)) (< new-time (cadr curr-dist)))
                                (begin
                                  (vector-set! dist v (list (car curr-dist) new-time))
                                  (set! q (append q (list v))))))))
                    (vector-ref graph u))
          (bfs))))

  (bfs)

  (define (wait-if-needed t)
    (let ((cycle-num (quotient t change)))
      (if (even? cycle-num)
          t
          (+ t (- change (modulo t change))))))

  (let ((first-time (car (vector-ref dist n)))
        (second-time (cadr (vector-ref dist n))))
    (if (= second-time +inf.0)
        #f
        (let loop ((current-time second-time) (current-node 1) (path '()))
              (if (= current-node n)
                  (let ((adjusted-time (wait-if-needed current-time)))
                      adjusted-time)
                  #f))))

  (wait-if-needed (cadr (vector-ref dist n))))