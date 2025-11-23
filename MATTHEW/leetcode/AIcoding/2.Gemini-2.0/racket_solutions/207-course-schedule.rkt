(define (can-finish num-courses prerequisites)
  (let* ([adj-list (make-vector num-courses '())]
         [in-degree (make-vector num-courses 0)]
         [q (list)])
    (for ([prerequisite prerequisites])
      (let ([course (car prerequisite)]
            [pre (cadr prerequisite)])
        (vector-set! adj-list pre (cons course (vector-ref adj-list pre)))
        (vector-set! in-degree course (+ 1 (vector-ref in-degree course)))))

    (for ([i (range num-courses)])
      (when (= 0 (vector-ref in-degree i))
        (set! q (append q (list i)))))

    (let loop ([count 0] [q q])
      (cond
        [(null? q) (= count num-courses)]
        [else
         (let ([course (car q)]
               [next-q (cdr q)])
           (let ([neighbors (vector-ref adj-list course)])
             (for ([neighbor neighbors])
               (vector-set! in-degree neighbor (- (vector-ref in-degree neighbor) 1))
               (when (= 0 (vector-ref in-degree neighbor))
                 (set! next-q (append next-q (list neighbor))))))
           (loop (+ count 1) next-q))])))