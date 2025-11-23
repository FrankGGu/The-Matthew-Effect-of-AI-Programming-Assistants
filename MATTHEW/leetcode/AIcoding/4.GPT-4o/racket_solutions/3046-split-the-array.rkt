(define (can-split-array nums m)
  (define (helper current-sum index count)
    (if (>= count m) #t
        (if (>= index (length nums)) #f
            (or (helper (+ current-sum (list-ref nums index)) (+ index 1) count)
                (helper current-sum (+ index 1) count)))))
  (helper 0 0 0))

(define (splitArray nums m)
  (can-split-array nums m))