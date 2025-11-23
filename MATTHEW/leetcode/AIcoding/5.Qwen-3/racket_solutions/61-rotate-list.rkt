(define (rotate-right head k)
  (if (or (null? head) (null? (cdr head)))
      head
      (let* ((n (length head))
             (k (modulo k n))
             (steps (- n k)))
        (let loop ((current head) (count 0))
          (if (= count steps)
              (let ((new-head (cdr current)))
                (set-cdr! current '())
                (let ((tail (find-tail new-head)))
                  (set-cdr! tail head)
                  new-head)
                )
              (loop (cdr current) (+ count 1)))))))

(define (length head)
  (let loop ((current head) (count 0))
    (if (null? current)
        count
        (loop (cdr current) (+ count 1)))))

(define (find-tail head)
  (if (null? (cdr head))
      head
      (find-tail (cdr head))))