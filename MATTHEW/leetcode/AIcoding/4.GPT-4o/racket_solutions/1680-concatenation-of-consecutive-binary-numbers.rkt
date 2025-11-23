(define (concatenatedBinary n)
  (define mod (expt 10 9))
  (define result 0)
  (define length 0)
  (for ((i (in-range 1 (+ n 1))))
    (when (= (bit-length i) length)
      (set! result (modulo (+ (bit-shift-left result (bit-length i)) i) mod)))
    (when (> (bit-length i) length)
      (set! length (bit-length i))
      (set! result (modulo (+ (bit-shift-left result (bit-length i)) i) mod))))
  result)

(define (concatenatedBinary n)
  (let loop ((i 1) (result 0) (length 0))
    (if (> i n)
        result
        (let* ((new-length (bit-length i))
               (result (modulo (+ (bit-shift-left result new-length) i) (expt 10 9))))
          (loop (+ i 1) result new-length)))))

(concatenatedBinary 3) ; This should return the result for the input n = 3