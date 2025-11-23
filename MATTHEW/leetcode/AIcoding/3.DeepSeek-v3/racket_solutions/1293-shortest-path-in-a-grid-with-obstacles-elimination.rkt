#lang racket

(require data/queue)

(define (shortest-path grid k)
  (define m (length grid))
  (define n (if (zero? m) 0 (length (car grid))))
  (define visited (make-hash))
  (define q (make-queue))
  (enqueue! q (list 0 0 k 0))
  (hash-set! visited (list 0 0 k) #t)

  (define dirs '((0 1) (1 0) (0 -1) (-1 0)))

  (let loop ()
    (if (queue-empty? q)
        -1
        (let* ([curr (dequeue! q)]
               [x (first curr)]
               [y (second curr)]
               [rem (third curr)]
               [steps (fourth curr)])
          (if (and (= x (- m 1)) (= y (- n 1)))
              steps
              (begin
                (for ([dir dirs])
                  (let* ([nx (+ x (first dir))]
                         [ny (+ y (second dir))])
                    (when (and (>= nx 0) (< nx m) (>= ny 0) (< ny n))
                      (let* ([new-rem (if (= (list-ref (list-ref grid nx) ny) 1)
                                          (- rem 1)
                                          rem)]
                             [key (list nx ny new-rem)])
                        (when (and (>= new-rem 0) (not (hash-has-key? visited key)))
                          (hash-set! visited key #t)
                          (enqueue! q (list nx ny new-rem (+ steps 1)))))))
                (loop))))))