(define/contract (minimum-effort tasks)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (define sorted-tasks (sort tasks (lambda (a b) (< (- (second a) (first a)) (- (second b) (first b))))))
  (define (helper tasks energy)
    (if (null? tasks)
        energy
        (let* ([task (car tasks)]
               [required (second task)]
               [cost (first task)])
          (helper (cdr tasks) (max (+ energy cost) required)))))
  (helper sorted-tasks 0))