(define (add-to-array-form A K)
  (let loop ((A (reverse A)) (K K) (carry 0) (result '()))
    (cond
      [(and (null? A) (= K 0) (= carry 0)) (reverse result)]
      [else
       (let* ((a (if (null? A) 0 (car A)))
              (sum (+ a (modulo K 10) carry))
              (new-carry (quotient sum 10))
              (new-K (quotient K 10))
              (new-result (cons (modulo sum 10) result)))
         (loop (if (null? A) '() (cdr A)) (+ new-K new-carry) new-carry new-result)))])))

(define (addToArrayForm A K)
  (add-to-array-form A K))