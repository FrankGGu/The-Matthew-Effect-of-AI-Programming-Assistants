(define (palindrome-permutation? s)
  (let ([counts (make-hash)])
    (for ([c (string->list s)])
      (hash-update! counts c (lambda (v) (+ v 1)) 1))
    (let ([odd-count (count (lambda (v) (odd? v)) (hash-values counts))])
      (<= odd-count 1))))

(define (solve queries s)
  (map (lambda (q)
         (let ([l (car q)]
               [r (cdr q)])
           (palindrome-permutation? (substring s l (+ r 1)))))
       queries))

(define (palindrome-rearrangement-queries s queries)
  (solve queries s))