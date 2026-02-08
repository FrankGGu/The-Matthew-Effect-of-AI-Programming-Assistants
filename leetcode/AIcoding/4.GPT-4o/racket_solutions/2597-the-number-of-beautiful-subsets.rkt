(define (beautiful-subsets nums k)
  (define (count-subsets idx total)
    (if (= idx (length nums))
        (if (> total 0) 1 0)
        (+ (count-subsets (+ idx 1) total)
           (count-subsets (+ idx 1) (if (or (= total 0) (not (= (list-ref nums idx) (+ total k))))
                                          (+ total (list-ref nums idx)) total)))))
  (count-subsets 0 0))

(define (number-of-beautiful-subsets nums k)
  (sub1 (beautiful-subsets nums k)))

(number-of-beautiful-subsets '(1 2 3) 2)