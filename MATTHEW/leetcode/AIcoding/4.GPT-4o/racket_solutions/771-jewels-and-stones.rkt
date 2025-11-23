(define (numJewelsInStones J S)
  (define jewel-set (set J))
  (define (count-stones stones)
    (if (null? stones)
        0
        (+ (if (set-member? jewel-set (car stones)) 1 0)
           (count-stones (cdr stones)))))
  (count-stones (string->list S)))

(numJewelsInStones "aA" "aAAbbbb")