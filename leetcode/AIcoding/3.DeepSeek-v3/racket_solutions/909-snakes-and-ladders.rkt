#lang racket

(define/contract (snakes-and-ladders board)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (define n (length board))
  (define target (* n n))
  (define (get-pos num)
    (let* ([row (- n (quotient (- num 1) n) 1)]
           [col (if (even? (quotient (- num 1) n))
                    (remainder (- num 1) n)
                    (- (- n 1) (remainder (- num 1) n)))])
      (list-ref (list-ref board row) col)))
  (define visited (make-hash))
  (define q (make-queue))
  (enqueue! q (list 1 0))
  (hash-set! visited 1 #t)
  (let loop ()
    (if (queue-empty? q)
        -1
        (let* ([current (dequeue! q)]
               [num (car current)]
               [steps (cadr current)])
          (if (= num target)
              steps
              (begin
                (for ([i (in-range 1 (min 7 (- (add1 target) num)))])
                  (let* ([next-num (+ num i)]
                         [next-pos (get-pos next-num)]
                         [next (if (= next-pos -1) next-num next-pos)]))
                  (unless (hash-ref visited next #f)
                    (hash-set! visited next #t)
                    (enqueue! q (list next (add1 steps)))))
                (loop))))))