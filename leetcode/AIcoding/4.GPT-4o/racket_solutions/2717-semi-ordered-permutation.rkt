(define (semiOrderedPermutation nums)
  (define n (length nums))
  (define first (index-of nums 1))
  (define last (index-of nums n))
  (define swaps
    (+ (if (< first last) first (- (sub1 n) last))
       (if (< first last) 0 (sub1 n))))
  swaps)

(define (index-of lst val)
  (for/fold ([i 0]) ([x lst])
    (if (= x val) i (add1 i))))