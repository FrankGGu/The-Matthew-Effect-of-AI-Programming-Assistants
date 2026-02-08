(define (number-of-pairs nums)
  (let loop ([counts (hash)] [pairs 0] [rem (length nums)])
    (cond
      [(empty? nums) (values pairs rem)]
      [else
       (let ([first (car nums)])
         (cond
           [(hash-has-key? counts first)
            (let ([count (hash-ref counts first)])
              (cond
                [(= count 1)
                 (loop (hash-remove counts first) (+ pairs 1) (- rem 2))]
                [else
                 (loop (hash-set counts first (- count 1)) (+ pairs 1) (- rem 2))]))]
           [else
            (loop (hash-set counts first 1) pairs rem (cdr nums))]))])))

(define (maximum-number-of-pairs nums)
  (let-values ([(pairs rem) (number-of-pairs nums)])
    (list pairs rem)))