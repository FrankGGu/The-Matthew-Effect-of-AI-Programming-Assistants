(define (max-length-good-subsequence nums k)
  (let ([n (length nums)])
    (define (good-subsequence? sub)
      (cond
        [(empty? sub) #t]
        [else
         (let ([first (car sub)]
               [rest (cdr sub)])
           (and (<= first (* k (apply + rest)))
                (good-subsequence? rest)))]))

    (define (find-max-length idx current-sub)
      (cond
        [(= idx n) (if (good-subsequence? current-sub)
                       (length current-sub)
                       0)]
        [else
         (max (find-max-length (+ idx 1) current-sub)
              (find-max-length (+ idx 1) (append current-sub (list (list-ref nums idx)))))]))

    (find-max-length 0 '())))