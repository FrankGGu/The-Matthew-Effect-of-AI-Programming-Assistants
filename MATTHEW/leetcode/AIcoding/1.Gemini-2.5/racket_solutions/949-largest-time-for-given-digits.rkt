#lang racket

(define (largest-time-for-given-digits arr)
  (let* ([max-minutes -1]
         [result-time ""])

    (define (remove x lst)
      (cond
        [(null? lst) '()]
        [(equal? x (car lst)) (cdr lst)]
        [else (cons (car lst) (remove x (cdr lst)))]))

    (define (permutations lst)
      (if (null? lst)
          (list (list))
          (apply append
                 (for/list ([x lst])
                   (for/list ([p (permutations (remove x lst))])
                     (cons x p))))))

    (for ([p (permutations arr)])
      (let* ([d1 (list-ref p 0)]
             [d2 (list-ref p 1)]
             [d3 (list-ref p 2)]
             [d4 (list-ref p 3)]
             [hh (+ (* d1 10) d2)]
             [mm (+ (* d3 10) d4)])
        (when (and (<= 0 hh 23)
                   (<= 0 mm 59))
          (let ([current-minutes (+ (* hh 60) mm)])
            (when (> current-minutes max-minutes)
              (set! max-minutes current-minutes)
              (set! result-time (format "~a~a:~a~a" d1 d2 d3 d4)))))))

    result-time))