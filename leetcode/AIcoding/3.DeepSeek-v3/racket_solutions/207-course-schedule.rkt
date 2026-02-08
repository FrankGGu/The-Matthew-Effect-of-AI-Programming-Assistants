(define/contract (can-finish num-courses prerequisites)
  (-> exact-integer? (listof (listof exact-integer?)) boolean?)
  (let* ((graph (make-hash))
         (in-degree (make-vector num-courses 0))
    (for ([edge prerequisites])
      (let ([u (second edge)]
            [v (first edge)])
        (hash-update! graph u (lambda (lst) (cons v lst)) '())
        (vector-set! in-degree v (+ (vector-ref in-degree v) 1))))
    (let loop ([queue (for/list ([i (in-range num-courses)]
                                 #:when (zero? (vector-ref in-degree i)))
                        i)]
               [count 0])
      (if (null? queue)
          (= count num-courses)
          (let* ([u (car queue)]
                 [new-queue (cdr queue)]
                 [neighbors (hash-ref graph u '())])
            (for ([v neighbors])
              (vector-set! in-degree v (- (vector-ref in-degree v) 1))
              (when (zero? (vector-ref in-degree v))
                (set! new-queue (cons v new-queue))))
            (loop new-queue (+ count 1)))))))