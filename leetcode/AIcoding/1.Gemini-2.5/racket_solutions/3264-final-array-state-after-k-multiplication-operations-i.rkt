(define (final-array-state-after-k-multiplication-operations-i nums k)
  (let loop ((current-nums (sort nums <))
             (operations-left k))
    (if (or (zero? operations-left) (null? current-nums))
        current-nums
        (let* ((smallest (car current-nums))
               (rest (cdr current-nums))
               (new-smallest (* smallest 2))
               (new-list (insert-sorted rest new-smallest)))
          (loop new-list (- operations-left 1))))))

(define (insert-sorted lst val)
  (cond
    ((null? lst) (list val))
    ((< val (car lst)) (cons val lst))
    (else (cons (car lst) (insert-sorted (cdr lst) val)))))