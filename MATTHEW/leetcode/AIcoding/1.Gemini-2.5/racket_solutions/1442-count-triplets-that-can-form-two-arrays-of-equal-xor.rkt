(define (count-triplets arr-list)
  (let* ((n (length arr-list))
         (arr (list->vector arr-list)) ; Convert input list to vector for O(1) access
         (prefix-xor-vec (make-vector (+ n 1) 0)))

    ; Calculate prefix XORs
    (for ((idx (in-range n)))
      (vector-set! prefix-xor-vec (+ idx 1) (bitwise-xor (vector-ref prefix-xor-vec idx) (vector-ref arr idx))))

    (let ((count 0))
      (for ((i (in-range n)))
        (for ((k (in-range (+ i 1) n))) ; k from i+1 to n-1
          (when (= (bitwise-xor (vector-ref prefix-xor-vec (+ k 1)) (vector-ref prefix-xor-vec i)) 0)
            (set! count (+ count (- k i))))))
      count)))