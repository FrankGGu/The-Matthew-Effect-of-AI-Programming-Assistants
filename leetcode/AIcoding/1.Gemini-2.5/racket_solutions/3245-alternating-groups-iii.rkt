(define (alternating-groups colors k)
  (let* ((n (length colors))
         (extended-colors (append colors (take colors (max 0 (- k 1)))))
         (total-alternating-groups 0))
    (for ((i (in-range n)))
      (let loop ((j i) (current-group-is-alternating #t))
        (cond
          ((not current-group-is-alternating) #f)
          ((>= j (+ i k -1))
           (when current-group-is-alternating
             (set! total-alternating-groups (add1 total-alternating-groups)))
           #t)
          (else
           (let ((current-color (list-ref extended-colors j))
                 (next-color (list-ref extended-colors (add1 j))))
             (if (= current-color next-color)
                 (loop (add1 j) #f)
                 (loop (add1 j) #t)))))))
    total-alternating-groups))