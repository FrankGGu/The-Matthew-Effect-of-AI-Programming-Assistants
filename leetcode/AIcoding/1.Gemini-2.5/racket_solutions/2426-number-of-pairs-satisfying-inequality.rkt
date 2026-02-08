(define (number-of-pairs nums1 nums2 diff)
  (define arr (map - nums1 nums2))

  (define (merge-sort-and-count lst)
    (define len (length lst))
    (cond
      [(= len 0) (cons 0 '())]
      [(= len 1) (cons 0 lst)]
      [else
       (define mid (quotient len 2))
       (define left (take lst mid))
       (define right (drop lst mid))

       (define left-result (merge-sort-and-count left))
       (define right-result (merge-sort-and-count right))

       (define left-count (car left-result))
       (define sorted-left (cdr left-result))
       (define right-count (car right-result))
       (define sorted-right (cdr right-result))

       (define (calculate-cross-count sl sr)
         (let ([sr-len (length sr)])
           (let loop ([l-current sl] [r-current sr] [r-current-idx 0] [count 0])
             (cond
               [(empty? l-current) count]
               [else
                (let ([x (car l-current)])
                  (let advance-r ([r-sublist r-current] [r-sublist-idx r-current-idx])
                    (cond
                      [(empty? r-sublist)
                       (loop (cdr l-current) r-sublist r-sublist-idx count)]
                      [(< (car r-sublist) (- x diff))
                       (advance-r (cdr r-sublist) (+ r-sublist-idx 1))]
                      [else
                       (loop (cdr l-current) r-sublist r-sublist-idx (+ count (- sr-len r-sublist-idx)))])))])))
         )

       (define cross-count (calculate-cross-count sorted-left sorted-right))

       (define (merge-lists l1 l2)
         (cond
           [(empty? l1) l2]
           [(empty? l2) l1]
           [(<= (car l1) (car l2)) (cons (car l1) (merge-lists (cdr l1) l2))]
           [else (cons (car l2) (merge-lists l1 (cdr l2)))]))

       (define merged-list (merge-lists sorted-left sorted-right))

       (cons (+ left-count right-count cross-count) merged-list)]))

  (car (merge-sort-and-count arr)))