(define/contract (length-of-longest-substring s)
  (-> string? exact-integer?)
  (let loop ([left 0] [right 0] [max-len 0] [seen (make-hash)])
    (cond
      [(>= right (string-length s)) max-len]
      [else
       (let ([char (string-ref s right)])
         (if (hash-has-key? seen char)
             (let ([new-left (max left (add1 (hash-ref seen char)))])
               (loop new-left (add1 right) max-len (hash-set (hash-remove seen (string-ref s (sub1 new-left))) char right)))
             (loop left (add1 right) (max max-len (- (add1 right) left)) (hash-set seen char right))))])))