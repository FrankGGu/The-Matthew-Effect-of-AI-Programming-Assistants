#lang racket

(define (check-equal-frequencies freq-ht)
  (let* ([all-freqs (hash-values freq-ht)]
         [non-zero-freqs (filter (lambda (v) (> v 0)) all-freqs)])
    (cond
      [(empty? non-zero-freqs) #t]
      [else
       (let ([first-freq (car non-zero-freqs)])
         (andmap (lambda (f) (= f first-freq)) non-zero-freqs))])))

(define (equal-frequency word)
  (let* ([n (string-length word)]
         [initial-freq-map (make-hash)])

    (for ([i (in-range n)])
      (let ([char (string-ref word i)])
        (hash-set! initial-freq-map char (+ (hash-ref initial-freq-map char 0) 1))))

    (let loop ([i 0])
      (cond
        [(= i n) #f]
        [else
         (let* ([char-to-remove (string-ref word i)]
                [temp-freq-map (make-hash)])

           (hash-for-each (lambda (k v) (hash-set! temp-freq-map k v)) initial-freq-map)

           (hash-update! temp-freq-map char-to-remove (lambda (v) (- v 1)))

           (if (check-equal-frequencies temp-freq-map)
               #t
               (loop (+ i 1))))]))))