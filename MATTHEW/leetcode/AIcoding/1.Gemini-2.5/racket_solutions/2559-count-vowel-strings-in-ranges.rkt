#lang racket

(define (is-vowel? c)
  (member c '(#\a #\e #\i #\o #\u)))

(define (is-vowel-string? s)
  (and (is-vowel? (char-downcase (string-ref s 0)))
       (is-vowel? (char-downcase (string-ref s (- (string-length s) 1))))))

(define (vowel-strings-in-ranges words queries)
  (let* ([n (length words)]
         [vowel-flags (map (lambda (s) (if (is-vowel-string? s) 1 0)) words)]
         [prefix-sums (make-vector (+ n 1) 0)])

    (for ([i (in-range n)])
      (vector-set! prefix-sums (+ i 1) (+ (vector-ref prefix-sums i) (list-ref vowel-flags i))))

    (map (lambda (query)
           (let ([start (car query)]
                 [end (cadr query)])
             (- (vector-ref prefix-sums (+ end 1))
                (vector-ref prefix-sums start))))
         queries)))