#lang racket

(define (string->char-counts s)
  (define counts (make-hash))
  (for ([char (in-string s)])
    (hash-set! counts char (+ (hash-ref counts char 0) 1)))
  counts)

(define (hash-equal? h1 h2)
  (and (= (hash-count h1) (hash-count h2))
       (andmap (lambda (k)
                 (and (hash-has-key? h2 k)
                      (= (hash-ref h1 k) (hash-ref h2 k))))
               (hash-keys h1))))

(define (hash-divided-string s k)
  (define n (string-length s))

  (if (or (zero? k) (not (zero? (remainder n k))))
      #f
      (let ([part-len (/ n k)])
        (if (zero? part-len) ; This implies n is 0.
            #f ; If n=0 and k>=1, cannot form k non-empty parts.
            (let ([first-part-counts (string->char-counts (substring s 0 part-len))])
              (let loop ([i part-len])
                (if (= i n)
                    #t
                    (let ([current-part-counts (string->char-counts (substring s i (+ i part-len)))])
                      (if (hash-equal? first-part-counts current-part-counts)
                          (loop (+ i part-len))
                          #f)))))))))