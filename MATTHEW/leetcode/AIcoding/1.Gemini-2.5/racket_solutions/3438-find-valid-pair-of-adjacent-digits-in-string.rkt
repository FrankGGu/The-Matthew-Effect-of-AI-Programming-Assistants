(define (find-valid-pair s)
  (let ((len (string-length s)))
    (if (< len 2)
        #f
        (let loop ((i 0))
          (if (>= i (- len 1))
              #f
              (if (char=? (string-ref s i) (string-ref s (+ i 1)))
                  #t
                  (loop (+ i 1))))))))