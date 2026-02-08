(define (num-subseq nums target)
  (define mod 1000000007)
  (define (power a b)
    (if (= b 0)
        1
        (modulo (* a (power a (- b 1))) mod)))
  (define sorted-nums (sort nums <))
  (define (count-valid-subsequences left right count)
    (if (>= left (length sorted-nums))
        count
        (if (< (+ (list-ref sorted-nums left) (list-ref sorted-nums right)) target)
            (count-valid-subsequences left (+ right 1) 
                (modulo (+ count (power 2 (- right left))) mod))
            (count-valid-subsequences (+ left 1) right count))))
  (count-valid-subsequences 0 (- (length sorted-nums) 1) 0))

(define (numSubseq nums target)
  (num-subseq nums target))