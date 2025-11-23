(define (init)
  (box '()))

(define (insert box key value)
  (define current (unbox box))
  (set-box! box (cons (cons key value) current)))

(define (sum box prefix)
  (define current (unbox box))
  (define (starts-with? str prefix)
    (and (>= (string-length str) (string-length prefix))
         (equal? (substring str 0 (string-length prefix)) prefix)))
  (define (sum-helper lst acc)
    (cond
      [(null? lst) acc]
      [else
       (let ((pair (car lst)))
         (if (starts-with? (car pair) prefix)
             (sum-helper (cdr lst) (+ acc (cdr pair)))
             (sum-helper (cdr lst) acc)))]))
  (sum-helper current 0))