(define (count-smaller-numbers-after-self nums)
  (letrec ((merge-sort
            (lambda (arr)
              (if (null? arr)
                  '()
                  (if (null? (cdr arr))
                      arr
                      (let* ((mid (floor (/ (length arr) 2)))
                             (left (take arr mid))
                             (right (drop arr mid)))
                        (merge (merge-sort left) (merge-sort right))))))
           (merge
            (lambda (left right)
              (if (null? left)
                  right
                  (if (null? right)
                      left
                      (if (<= (car left) (car right))
                          (cons (car left) (merge (cdr left) right))
                          (cons (car right) (merge left (cdr right)))))))
           (count-smaller
            (lambda (num sorted)
              (let loop ((lst sorted) (count 0))
                (cond
                  ((null? lst) count)
                  ((< (car lst) num) (loop (cdr lst) (+ count 1)))
                  (else count)))))
           (process-nums
            (lambda (nums sorted)
              (if (null? nums)
                  '()
                  (cons (count-smaller (car nums) sorted)
                        (process-nums (cdr nums) (merge-sort (append sorted (list (car nums)))))))))
           (helper
            (lambda (nums)
              (if (null? nums)
                  '()
                  (letrec ((result '()))
                    (for ((i (in-range (length nums))))
                      (let ((count 0))
                        (for ((j (in-range (+ i 1) (length nums))))
                          (if (< (list-ref nums j) (list-ref nums i))
                              (set! count (+ count 1)))))
                      (set! result (append result (list count)))))
                    result)))))
    (helper nums)))