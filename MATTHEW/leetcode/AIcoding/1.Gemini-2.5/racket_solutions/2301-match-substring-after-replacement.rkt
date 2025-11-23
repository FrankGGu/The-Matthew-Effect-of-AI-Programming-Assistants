#lang racket

(define (match-substring-after-replacement s sub replacements)
  (define s-len (string-length s))
  (define sub-len (string-length sub))

  (define replacement-map (make-hash))
  (for ([rule replacements])
    (define c1 (string-ref (car rule) 0))
    (define c2 (string-ref (cadr rule) 0))
    (hash-update! replacement-map c1 (lambda (s) (set-add s c2)) (set)))

  (for/or ([i (in-range (+ (- s-len sub-len) 1))])
    (let ([current-match? #t])
      (for ([k (in-range sub-len)])
        (define s-char (string-ref s (+ i k)))
        (define sub-char (string-ref sub k))

        (unless (char=? s-char sub-char)
          (define possible-replacements (hash-ref replacement-map s-char (set)))
          (unless (set-member? possible-replacements sub-char)
            (set! current-match? #f)
            (break))))

      current-match?)))