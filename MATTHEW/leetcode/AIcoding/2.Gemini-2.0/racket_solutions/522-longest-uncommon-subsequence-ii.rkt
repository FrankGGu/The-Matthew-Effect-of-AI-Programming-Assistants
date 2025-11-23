(define (is-subsequence? s t)
  (define (helper s t s-idx t-idx)
    (cond
      [(= s-idx (string-length s)) #t]
      [(= t-idx (string-length t)) #f]
      [(char=? (string-ref s s-idx) (string-ref t t-idx)) (helper s t (+ s-idx 1) (+ t-idx 1))]
      [else (helper s t s-idx (+ t-idx 1))]))
  (helper s t 0 0))

(define (findLUSlength strs)
  (define (helper strs idx)
    (cond
      [(< idx 0) -1]
      [else
       (define s (list-ref strs idx))
       (define subsequence?
         (ormap
          (lambda (str-idx)
            (and (!= str-idx idx) (is-subsequence? s (list-ref strs str-idx))))
          (range 0 (length strs))))
       (if subsequence?
           (helper strs (- idx 1))
           (string-length s))]))
  (define sorted-strs (sort strs string<=?))
  (helper (reverse sorted-strs) (- (length strs) 1)))