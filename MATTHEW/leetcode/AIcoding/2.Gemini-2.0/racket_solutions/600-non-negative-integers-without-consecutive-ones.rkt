(define (find-integers n)
  (let* ((fib (make-vector 32 0))
         (fib-loop (lambda (i)
                     (if (>= i 32)
                         'done
                         (begin
                           (vector-set! fib i (if (<= i 1) 1 (+ (vector-ref fib (- i 1)) (vector-ref fib (- i 2)))))
                           (fib-loop (+ i 1))))))
         (_ (fib-loop 0))
         (result 1)
         (prev-bit 0)
         (i 30))
    (let loop ((i i) (n n) (result result) (prev-bit prev-bit))
      (cond
        ((< i 0) result)
        ((> (bitwise-and n (arithmetic-shift 1 i)) 0)
         (set! n (bitwise-xor n (arithmetic-shift 1 i)))
         (set! result (+ result (vector-ref fib i)))
         (if (= prev-bit 1)
             0
             (loop (- i 1) n result 1)))
        (else
         (loop (- i 1) n result 0))))))