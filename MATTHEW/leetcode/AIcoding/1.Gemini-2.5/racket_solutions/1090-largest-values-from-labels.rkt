(define (largest-values-from-labels values labels num-wanted use-limit)
  (let* ([items (map (lambda (v l) (cons v l)) values labels)]
         [sorted-items (sort items (lambda (a b) (> (car a) (car b))))]
         [label-counts (make-hash)]
         [total-sum 0]
         [items-picked 0])
    (for-each (lambda (item)
                (let* ([value (car item)]
                       [label (cdr item)]
                       [current-label-count (hash-ref label-counts label 0)])
                  (when (and (< items-picked num-wanted)
                             (< current-label-count use-limit))
                    (set! total-sum (+ total-sum value))
                    (set! items-picked (+ items-picked 1))
                    (hash-set! label-counts label (+ current-label-count 1)))))
              sorted-items)
    total-sum))