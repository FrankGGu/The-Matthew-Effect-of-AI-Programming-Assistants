(define (can-split-array nums k)
  (define (helper nums k prev)
    (if (null? nums)
        (>= k 1)
        (let ((current (car nums))
              (rest (cdr nums)))
          (or (and (>= current prev) (helper rest k current))
              (helper rest (- k 1) current)))))
  (if (< (length nums) 2)
      #t
      (helper nums k -1)))

(can-split-array '(1 2 3 4) 1) ; Adjust the input as needed for testing