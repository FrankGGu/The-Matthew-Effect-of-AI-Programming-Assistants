#lang racket

(define (average-of-levels root)
  (define (bfs queue result)
    (cond [(null? queue) (map / result)]
          [else
           (define level-size (length queue))
           (define sum (apply + (map car queue)))
           (define next-queue (append* (map cdr queue)))
           (bfs next-queue (cons (/ sum level-size) result))]))
  (if (null? root)
      '()
      (bfs (list (cons (car root) (cdr root))) '())))

(define (make-tree . args)
  (define (build i)
    (if (>= i (length args))
        #f
        (if (eqv? (list-ref args i) 'null)
            #f
            (list (list-ref args i)
                  (build (+ i 1))
                  (build (+ i 2))))))
  (build 0))