(define (count-unique-xor-triplets nums)
  (define n (length nums))
  (define unique-xors (make-hash))
  (for ([i (in-range n)])
    (for ([j (in-range i)])
      (for ([k (in-range j)])
        (let ([xor-value (bitwise-xor (list-ref nums i) (list-ref nums j) (list-ref nums k)))]
              [triplet (sort (list (list-ref nums i) (list-ref nums j) (list-ref nums k)) <)])
          (hash-set! unique-xors triplet xor-value)))))
  (hash-count unique-xors))

(define (num-unique-xor-triplets nums)
  (count-unique-xor-triplets nums))