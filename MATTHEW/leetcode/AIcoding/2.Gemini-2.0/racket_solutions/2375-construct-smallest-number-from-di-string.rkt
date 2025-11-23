(define (smallest-number di-string)
  (let* ([n (string-length di-string)]
         [result (make-vector (+ n 1) 0)]
         [stack '()]
         (define (helper i current)
           (cond
             [(or (= i n) (char=? (string-ref di-string i) #\I))
              (push-stack current)
              (let loop ([s stack])
                (cond
                  [(empty? s) #t]
                  [else
                   (vector-set! result (- n (length s)) (car s))
                   (loop (cdr s))]))
              (set! stack '())
              (cond
                [(= i n) #t]
                [else (helper (+ i 1) (+ current 1))])]
             [else
              (set! stack (cons current stack))
              (helper (+ i 1) (+ current 1))]))
         (push-stack (lambda (x) (set! stack (cons x stack)))))
    (helper 0 1)
    (list->string (map (lambda (x) (integer->char (+ x (char->integer #\0)))) (vector->list result)))))