(define (detect-pattern arr m k)
  (let* ((n (vector-length arr))
         (required-matches (* (- k 1) m)))
    (if (= k 1)
        #t
        (let loop ((i 0) (count 0))
          (cond
            ((>= i (- n m)) #f)
            ((= (vector-ref arr i) (vector-ref arr (+ i m)))
             (let ((new-count (+ count 1)))
               (if (>= new-count required-matches)
                   #t
                   (loop (+ i 1) new-count))))
            (else
             (loop (+ i 1) 0)))))))