(define/contract (task-scheduler-ii tasks space)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([tasks tasks]
              [day 0]
              [last-seen (make-hash)])
    (if (null? tasks)
        day
        (let* ([task (car tasks)]
               [last-day (hash-ref last-seen task -1)]
               [next-day (max day (+ last-day space 1))])
          (hash-set! last-seen task next-day)
          (loop (cdr tasks) (+ next-day 1) last-seen)))))