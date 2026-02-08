(define (min-travel-time locations capacity)
  (let* ([n (length locations)]
         [sorted-locations (sort locations <)]
         (define (calculate-cost groups)
           (apply + (map (lambda (group)
                            (let ([min-val (apply min group)]
                                  [max-val (apply max group)])
                              (- max-val min-val)))
                          groups)))
         (define (solve index current-groups current-capacity)
           (if (= index n)
               (calculate-cost current-groups)
               (let ([last-group (last current-groups)])
                 (if (and (not (null? last-group)) (< (length last-group) capacity))
                     (min (solve (+ index 1) (append (drop-right current-groups 1) (list (append last-group (list (list-ref sorted-locations index))))) current-capacity)
                          (solve (+ index 1) (append current-groups (list (list (list-ref sorted-locations index))))) current-capacity)
                     (solve (+ index 1) (append current-groups (list (list (list-ref sorted-locations index))))) current-capacity)))))
    (solve 0 '() capacity)))