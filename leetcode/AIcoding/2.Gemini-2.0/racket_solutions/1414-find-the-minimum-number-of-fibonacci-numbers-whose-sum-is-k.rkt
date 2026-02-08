(define (find-min-fibonacci-numbers k)
  (define fibs (list 1 1))
  (let loop ((a (car fibs)) (b (cadr fibs)))
    (if (> (+ a b) k)
        (reverse fibs)
        (begin
          (set! fibs (cons (+ a b) fibs))
          (loop b (+ a b)))))
  (define (solve k fibs count)
    (cond
      ((= k 0) count)
      ((< k (car fibs)) (solve k (cdr fibs) count))
      (else (solve (- k (car fibs)) fibs (+ count 1)))))
  (solve k fibs 0))