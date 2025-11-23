(define (minOperations nums)
  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (modulo a b))))

  (define g (foldl gcd (car nums) (cdr nums)))
  (if (= g 1)
      0
      (define (count-ones lst)
        (foldl (lambda (x y) (if (= y 1) (+ x 1) x)) 0 lst))
      (define ones (count-ones nums))
      (if (> ones 0)
          (length nums) 
          (let ((min-ops (foldl (lambda (x y) (if (= y 1) (min x (+ (count-ones (filter (lambda (z) (not (= z y))) nums)) 1)) x)) x)) (length nums) (remove-duplicates nums)))
            min-ops)))))