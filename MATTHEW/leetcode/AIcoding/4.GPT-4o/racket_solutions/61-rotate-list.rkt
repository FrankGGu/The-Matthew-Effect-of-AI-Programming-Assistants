(define (rotate-list head k)
  (when (and head (> k 0))
    (define length (let loop ((node head) (count 0))
                     (if (null? node)
                         count
                         (loop (cdr node) (+ count 1)))))
    (define k (modulo k length))
    (if (= k 0) head
        (let loop ((node head) (count 0))
          (if (= count (- length k))
              (let ((new-head (cdr node)))
                (define tail (let loop ((n new-head))
                               (if (null? (cdr n))
                                   n
                                   (loop (cdr n)))))
                (set-cdr! tail head)
                new-head)
              (loop (cdr node) (+ count 1)))))))