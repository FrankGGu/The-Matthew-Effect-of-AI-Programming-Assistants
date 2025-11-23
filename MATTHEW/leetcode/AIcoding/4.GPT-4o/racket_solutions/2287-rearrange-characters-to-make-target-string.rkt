(define (rearrange-characters s target)
  (define (count-characters str)
    (foldl (lambda (c acc) (hash-update acc c (lambda (n) (+ n 1)) 0)) (hash) str))
  (define s-count (count-characters s))
  (define target-count (count-characters target))
  (foldl (lambda (k acc) (min acc (hash-ref s-count k 0) // (hash-ref target-count k 0))) 
          +inf.0 
          (hash-keys target-count)))
  (if (= (foldl + 0 (map (lambda (k) (min (hash-ref s-count k 0) (hash-ref target-count k 0))) 
                           (hash-keys target-count))) 
         (string-length target))
      #t
      #f))

(rearrange-characters "aabbcc" "abc") ; Example usage