(define (find-longest-word s dictionary)
  (let loop ([longest ""]
             [dict dictionary])
    (cond
      [(null? dict) longest]
      [else
       (let ([word (car dict)])
         (if (substring? word s)
             (if (> (string-length word) (string-length longest))
                 (loop word (cdr dict))
                 (if (and (= (string-length word) (string-length longest))
                          (string<? word longest))
                     (loop word (cdr dict))
                     (loop longest (cdr dict))))
             (loop longest (cdr dict))))])))

(define (substring? sub str)
  (let loop ([i 0]
             [j 0])
    (cond
      [(= j (string-length sub)) #t]
      [(= i (string-length str)) #f]
      [else
       (if (equal? (string-ref sub j) (string-ref str i))
           (loop (+ i 1) (+ j 1))
           (loop (+ i 1) j))])))