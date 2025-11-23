(define (can-form-array arr pieces)
  (define arr-vec (list->vector arr))
  (define arr-len (vector-length arr-vec))

  (define piece-map
    (for/fold ((h (hash))) ((p pieces))
      (hash-set h (car p) p)))

  (define (check-formation current-arr-idx)
    (cond
      ((= current-arr-idx arr-len) #t) ; Successfully processed all of arr

      (else
       (define current-arr-val (vector-ref arr-vec current-arr-idx))
       (define matching-piece (hash-ref piece-map current-arr-val #f))

       (cond
         ((not matching-piece) #f) ; No piece starts with current-arr-val

         (else
          (define piece-len (length matching-piece))

          (if (> (+ current-arr-idx piece-len) arr-len)
              #f ; The piece is too long to fit in the remaining array

              (let ((match?
                     (for/all ((p-val matching-piece)
                               (i (in-range piece-len)))
                       (= p-val (vector-ref arr-vec (+ current-arr-idx i))))))
                (if match?
                    (check-formation (+ current-arr-idx piece-len))
                    #f))))))))

  (check-formation 0))