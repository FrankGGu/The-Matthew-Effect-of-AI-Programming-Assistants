(define (max-diff num)
  (define (number->list n)
    (if (< n 10)
        (list n)
        (append (number->list (quotient n 10)) (list (remainder n 10)))))
  (define (list->number lst)
    (foldl (lambda (x acc) (+ (* acc 10) x)) 0 lst))
  (define digits (number->list num))
  (define (find-min)
    (let loop ([i 0] [d #f] [sub #f])
      (cond
        [(= i (length digits)) (if sub sub digits))
        [(not d) (if (= (list-ref digits i) 1)
                  (loop (+ i 1) d sub)
                  (loop (+ i 1) (list-ref digits i) (list-ref digits i)))]
        [(= (list-ref digits i) d) (loop (+ i 1) d (if sub sub 0))]
        [else (loop (+ i 1) d sub)])))
  (define (find-max)
    (let loop ([i 0] [d #f] [sub #f])
      (cond
        [(= i (length digits)) (if sub sub digits))
        [(not d) (if (= (list-ref digits i) 9)
                  (loop (+ i 1) d sub)
                  (loop (+ i 1) (list-ref digits i) 9))]
        [(= (list-ref digits i) d) (loop (+ i 1) d 9)]
        [else (loop (+ i 1) d sub)])))
  (define min-num (list->number (find-min)))
  (define max-num (list->number (find-max)))
  (- max-num min-num))