(define (longest-subarray nums limit)
  (let* ((n (length nums))
         (max-len 0))
    (for ([i (in-range n)])
      (let loop ([j i] [min-val (list-ref nums i)] [max-val (list-ref nums i)])
        (cond [(>= j n) (set! max-len (max max-len (- j i)))]
              [else
               (let ((new-min (min min-val (list-ref nums j)))
                     (new-max (max max-val (list-ref nums j))))
                 (cond [(<= (- new-max new-min) limit)
                        (loop (+ j 1) new-min new-max)]
                       [else (set! max-len (max max-len (- j i)))]))])))
    max-len))