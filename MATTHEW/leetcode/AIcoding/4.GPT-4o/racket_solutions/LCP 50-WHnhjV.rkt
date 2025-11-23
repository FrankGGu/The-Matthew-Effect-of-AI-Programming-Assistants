(define (numJewelsInStones J S)
  (define jewel-set (string->list J))
  (define stone-list (string->list S))
  (define (count-jewels jewels stones)
    (if (null? stones)
        0
        (+ (if (member (car stones) jewels) 1 0)
           (count-jewels jewels (cdr stones)))))
  (count-jewels jewel-set stone-list))

(numJewelsInStones "aA" "aAAbbbb")
(numJewelsInStones "z" "ZZ")