(define (minimum-seconds peaks)
  (define n (length peaks))
  (define (calculate-seconds groups)
    (apply + (map (lambda (group) (apply max group)) groups)))

  (define (solve idx current-groups)
    (if (= idx n)
        (calculate-seconds current-groups)
        (let* ((val (list-ref peaks idx))
               (existing-group (findf (lambda (group) (member val group)) current-groups)))
          (if existing-group
              (solve (+ idx 1) (map (lambda (group) (if (equal? group existing-group) (cons val group) group)) current-groups))
              (min (solve (+ idx 1) (cons (list val) current-groups))
                   (if (empty? current-groups)
                       (infinite)
                       (solve (+ idx 1) (map (lambda (group) (cons val group)) current-groups))))))))

  (define (infinite)
    (expt 10 10))

  (solve 0 '()))