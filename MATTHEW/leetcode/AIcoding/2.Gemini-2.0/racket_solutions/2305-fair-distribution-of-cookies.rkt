(define (distribute-cookies cookies k)
  (define (solve index current-sums)
    (if (= index (length cookies))
        (apply max current-sums)
        (let loop ((i 0))
          (if (= i k)
              #f
              (let ((new-sums (list-set current-sums i (+ (list-ref current-sums i) (list-ref cookies index)))))
                (let ((result (solve (+ index 1) new-sums)))
                  (if result
                      (let ((next-result (loop (+ i 1))))
                        (if next-result
                            (min result next-result)
                            result))
                      (loop (+ i 1)))))))))

  (solve 0 (make-list k 0)))