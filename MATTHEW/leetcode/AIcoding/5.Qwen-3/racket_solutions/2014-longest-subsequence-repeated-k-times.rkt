#lang racket

(define (longest-repeated-subsequence-repeated-k-times seq k)
  (define n (string-length seq))
  (define (valid? s)
    (let loop ((i 0) (count 0))
      (cond
        [(= count k) #t]
        [(>= i n) #f]
        [else
         (let ([pos (string-index seq s i)])
           (if pos
               (loop (+ pos (string-length s)) (+ count 1))
               #f))])))
  (define (string-index s sub start)
    (let loop ([i start])
      (and (< i (string-length s))
           (let ([j 0])
             (let loop2 ([i i] [j j])
               (cond
                 [(= j (string-length sub)) i]
                 [(or (= i (string-length s)) (not (char=? (string-ref s i) (string-ref sub j)))) #f]
                 [else (loop2 (+ i 1) (+ j 1))]))))))
  (define (generate-substrings len)
    (let loop ([i 0] [res '()])
      (if (> i (- n len))
          res
          (loop (+ i 1) (cons (substring seq i (+ i len)) res)))))
  (let loop ([len (min (floor (/ n k)) n)])
    (if (= len 0)
        ""
        (let ([candidates (generate-substrings len)])
          (let ([found (for/first ([s candidates] #:when (valid? s)) s)])
            (if found
                found
                (loop (- len 1))))))))