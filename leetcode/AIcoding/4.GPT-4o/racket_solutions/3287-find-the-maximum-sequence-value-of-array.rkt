(define (max-sequence-value arr)
  (if (null? arr)
      0
      (let loop ((lst arr) (max-val (car arr)))
        (cond ((null? lst) max-val)
              ((> (car lst) max-val) (loop (cdr lst) (car lst)))
              (else (loop (cdr lst) max-val))))))

(define (findMaxSequenceValue arr)
  (max-sequence-value arr))