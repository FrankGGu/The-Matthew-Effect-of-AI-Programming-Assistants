(define (maximizeSubarrays nums)
  (define n (length nums))
  (define (max-sum sub)
    (foldl + 0 sub))

  (define (find-conflict)
    (for/fold ([conflict #f]) ([i (in-range 1 n)])
      (if (and (not conflict) (= (list-ref nums (- i 1)) (list-ref nums i)))
          (list-ref nums i)
          conflict)))

  (define conflict (find-conflict))
  (if (not conflict)
      (max-sum nums)
      (max (max-sum (filter (lambda (x) (not (= x conflict))) nums))
           (max-sum (filter (lambda (x) (not (= x (list-ref nums (- (index-of nums conflict) 1))))) nums)))))

  (maximizeSubarrays nums))