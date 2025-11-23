(define (max-probability n edges succ-prob start end)
  (let* ((graph (make-hash))
         (probs (make-vector n 0.0))
         (pq (make-mutable-priority-queue #:priority (lambda (x) (vector-ref probs x)) #:less-than? >)))
    (vector-set! probs start 1.0)
    (mutable-priority-queue-add! pq start)
    (for ([i (in-range (length edges))])
      (let* ([edge (list-ref edges i)]
             [u (list-ref edge 0)]
             [v (list-ref edge 1)]
             [prob (list-ref succ-prob i)])
        (hash-update! graph u (lambda (l) (cons (cons v prob) l)) '())
        (hash-update! graph v (lambda (l) (cons (cons u prob) l)) '())))

    (let loop ()
      (if (mutable-priority-queue-empty? pq)
          (vector-ref probs end)
          (let* ([u (mutable-priority-queue-remove! pq)]
                 [neighbors (hash-ref graph u '())])
            (for ([neighbor neighbors])
              (let* ([v (car neighbor)]
                     [prob (cdr neighbor)])
                (when (> (* (vector-ref probs u) prob) (vector-ref probs v))
                  (vector-set! probs v (* (vector-ref probs u) prob))
                  (mutable-priority-queue-add! pq v))))
            (loop)))))