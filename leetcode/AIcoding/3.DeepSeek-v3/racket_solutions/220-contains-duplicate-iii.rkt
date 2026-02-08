(define/contract (contains-nearby-almost-duplicate nums k t)
  (-> (listof exact-integer?) exact-integer? exact-integer? boolean?)
  (let loop ([i 0] [seen (make-hash)])
    (cond
      [(>= i (length nums)) #f]
      [else
       (let* ([num (list-ref nums i)]
              [bucket (quotient num (max 1 t))]
              [candidates (list (sub1 bucket) bucket (add1 bucket))])
         (if (for/or ([c candidates])
               (and (hash-has-key? seen c)
                    (<= (abs (- num (hash-ref seen c))) t)))
             #t
             (begin
               (hash-set! seen bucket num)
               (when (>= (hash-count seen) k)
                 (hash-remove! seen (quotient (list-ref nums (- i k)) (max 1 t))))
               (loop (add1 i) seen))))])))