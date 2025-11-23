(define (happy? n)
  (let loop ([n n] [seen (set)])
    (cond
      [(set-member? seen n) #f]
      [(= n 1) #t]
      [else (loop (sum-of-squares (digits n)) (set-add seen n))])))

(define (digits n)
  (if (= n 0)
      '()
      (cons (modulo n 10) (digits (quotient n 10)))))

(define (sum-of-squares lst)
  (foldl + 0 (map (lambda (x) (* x x)) lst)))