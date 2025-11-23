(define (canReach s min-jump max-jump)
  (define n (string-length s))
  (define q (list 0))
  (define visited (make-vector n #f))
  (vector-set! visited 0 #t)

  (let loop ((q q))
    (cond
      [(null? q) #f]
      [else
       (let ((curr (car q)))
         (for ((i (in-range (+ curr min-jump) (+ curr max-jump 1))))
           (when (and (< i n) (not (vector-ref visited i)) (char=? (string-ref s i) #\0))
             (vector-set! visited i #t)
             (set! q (append q (list i)))))
         (if (vector-ref visited (- n 1))
             #t
             (loop (cdr q))))])))