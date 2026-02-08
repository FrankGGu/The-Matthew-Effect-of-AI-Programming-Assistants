(define (min-falling-path-sum grid)
  (define (find-two-smallest-and-indices lst)
    (let loop ((idx 0)
               (min1 +inf.0)
               (idx1 -1)
               (min2 +inf.0)
               (rest lst))
      (if (empty? rest)
          (list min1 idx1 min2)
          (let ((current-val (car rest)))
            (if (< current-val min1)
                (loop (+ idx 1)
                      current-val
                      idx
                      min1
                      (cdr rest))
                (if (< current-val min2)
                    (loop (+ idx 1)
                          min1
                          idx1
                          current-val
                          (cdr rest))
                    (loop (+ idx 1)
                          min1
                          idx1
                          min2
                          (cdr rest))))))))

  (let* ((n (length grid))
         (first-row (car grid)))
    (if (= n 1)
        (car first-row)
        (let loop ((r 1)
                   (prev-dp-row first-row))
          (if (= r n)
              (apply min prev-dp-row)
              (let* ((current-grid-row (list-ref grid r))
                     (two-smallest (find-two-smallest-and-indices prev-dp-row))
                     (min1 (list-ref two-smallest 0))
                     (idx1 (list-ref two-smallest 1))
                     (min2 (list-ref two-smallest 2))
                     (current-dp-row
                      (build-list n
                                  (lambda (c)
                                    (+ (list-ref current-grid-row c)
                                       (if (= c idx1) min2 min1))))))
                (loop (+ r 1) current-dp-row)))))))