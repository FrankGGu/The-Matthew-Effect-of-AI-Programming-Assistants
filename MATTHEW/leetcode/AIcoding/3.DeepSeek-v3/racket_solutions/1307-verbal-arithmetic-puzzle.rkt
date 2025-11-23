#lang racket

(define (isSolvable words result)
  (define all-words (append words (list result)))
  (define first-chars (remove-duplicates (map (lambda (w) (string-ref w 0)) all-words)))
  (define chars (remove-duplicates (flatten (map string->list all-words))))
  (define n (length chars))
  (define leading-zero (make-hash))

  (for ([w all-words])
    (hash-set! leading-zero (string-ref w 0) #t))

  (define (backtrack used digits pos carry)
    (if (>= pos (string-length result))
        (zero? carry)
        (let ([sum carry])
          (for ([word words])
            (when (< pos (string-length word))
              (set! sum (+ sum (hash-ref digits (string-ref word pos) 0)))))
          (define res-char (if (< pos (string-length result)) (string-ref result pos) #f))
          (define rem (remainder sum 10))
          (cond
            [(not res-char) #f]
            [(hash-has-key? digits res-char)
             (if (= (hash-ref digits res-char) rem)
                 (backtrack used digits (+ pos 1) (quotient (- sum rem) 10))
                 #f)]
            [(hash-has-key? used rem) #f]
            [(and (zero? rem) (hash-has-key? leading-zero res-char)) #f]
            [else
             (hash-set! digits res-char rem)
             (hash-set! used rem #t)
             (define res (backtrack used digits (+ pos 1) (quotient (- sum rem) 10)))
             (hash-remove! used rem)
             (hash-remove! digits res-char)
             res]))))

  (define digits (make-hash))
  (define used (make-hash))
  (backtrack used digits 0 0))