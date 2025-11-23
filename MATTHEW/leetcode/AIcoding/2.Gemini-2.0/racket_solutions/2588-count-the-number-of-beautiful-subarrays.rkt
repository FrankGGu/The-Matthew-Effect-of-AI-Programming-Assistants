(define (count-beautiful-subarrays nums)
  (let ((n (length nums)))
    (let loop ((i 0) (prefix-xor 0) (xor-counts (make-hash)))
      (cond
        [(>= i n) (hash-ref xor-counts 0 0)]
        [else
         (let ((new-prefix-xor (bitwise-xor prefix-xor (list-ref nums i))))
           (let ((count (hash-ref xor-counts new-prefix-xor 0)))
             (hash-set! xor-counts new-prefix-xor (+ count 1))
             (+ (if (= new-prefix-xor 0) 1 0)
                (loop (+ i 1) new-prefix-xor xor-counts))))])))))