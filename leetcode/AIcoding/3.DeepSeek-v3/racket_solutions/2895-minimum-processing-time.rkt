(define/contract (min-processing-time processor-time tasks)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer?)
  (let* ([sorted-processor (sort processor-time <)]
         [sorted-tasks (sort tasks >)]
         [n (length sorted-processor)]
         [m (length sorted-tasks)]
         [max-time 0])
    (for ([i (in-range n)])
      (let ([current-time (+ (list-ref sorted-processor i) 
                             (list-ref sorted-tasks (* i 4)))])
        (when (> current-time max-time)
          (set! max-time current-time))))
    max-time))