(define (finding-users-active-minutes logs k)
  (let* ((user-activities (make-hash))
         (result (make-vector k 0)))
    (for ([log logs])
      (let ([user (first log)]
            [minute (second log)])
        (hash-update! user-activities user
                       (lambda (minutes) (set-add minutes minute))
                       (set))))
    (for ([user (hash-keys user-activities)])
      (let ([activity-count (set-count (hash-ref user-activities user))])
        (vector-set! result (- activity-count 1) (+ (vector-ref result (- activity-count 1)) 1))))
    result))