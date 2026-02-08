(define (find-max-length nums)
  (let loop ([i 0] [count 0] [max-len 0] [hash (make-hash (list (cons 0 -1)))])
    (cond
      [(= i (length nums)) max-len]
      [else
       (let* ([num (list-ref nums i)]
              [new-count (if (= num 1) (add1 count) (sub1 count))]
              [new-hash (if (hash-has-key? hash new-count)
                           hash
                           (hash-set hash new-count i))])
         (loop (add1 i) new-count (max max-len (- i (hash-ref hash new-count))) new-hash)])))