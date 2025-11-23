(define (judgePoint24 nums)
  (define (helper nums)
    (cond
      [(empty? nums) #f]
      [(empty? (rest nums)) (abs (- (first nums) 24)) < 0.001]
      [else
       (for*/or ([i (in-range (length nums))]
                 [j (in-range i (length nums))])
         (define a (list-ref nums i))
         (define b (list-ref nums j))
         (define rest-nums (remove* (list a b) nums))
         (or (helper (cons (+ a b) rest-nums))
             (helper (cons (- a b) rest-nums))
             (helper (cons (- b a) rest-nums))
             (helper (cons (* a b) rest-nums))
             (and (not (= b 0)) (helper (cons (/ a b) rest-nums)))
             (and (not (= a 0)) (helper (cons (/ b a) rest-nums)))))]))
  (helper nums))