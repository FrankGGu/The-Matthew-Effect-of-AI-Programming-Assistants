(define (count-nice-pairs nums)
  (define mod-val 1000000007)
  (define inv2 500000004) ; Modular inverse of 2 mod 10^9 + 7

  (define diff-counts (make-hash))

  (define (rev n)
    (string->number
     (list->string
      (reverse (string->list (number->string n))))))

  (for-each
   (lambda (num)
     (define diff (- num (rev num)))
     (hash-update! diff-counts diff (lambda (v) (+ v 1)) 0))
   nums)

  (define total-pairs 0)
  (hash-for-each
   (lambda (diff count)
     (when (> count 1)
       (define k count)
       (define term (modulo (* k (- k 1)) mod-val))
       (set! total-pairs
             (modulo (+ total-pairs
                        (modulo (* term inv2) mod-val))
                     mod-val))))
   diff-counts)
  total-pairs)