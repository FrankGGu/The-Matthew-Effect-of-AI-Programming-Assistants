(define (rotate-right head k)
  (cond
    [(or (null? head) (null? (cdr head))) head]
    [else
     (let* ([len (let loop ([node head] [count 0])
                      (if (null? node)
                          count
                          (loop (cdr node) (+ count 1))))]
            [k (modulo k len)])
       (if (= k 0)
           head
           (let loop ([node head] [count 1])
             (if (= count (- len k))
                 (let* ([new-head (cdr node)]
                        [tail (let tail-loop ([current new-head])
                                (if (null? (cdr current))
                                    current
                                    (tail-loop (cdr current))))])
                   (set-cdr! node null)
                   (set-cdr! tail head)
                   new-head)
                 (loop (cdr node) (+ count 1))))))])))