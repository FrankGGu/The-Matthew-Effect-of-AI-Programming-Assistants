(define (min-remove-to-make-valid-parentheses s)
  (define (helper s stack idx)
    (cond
      [(empty? s)
       (if (empty? stack)
           ""
           (let loop ([st stack] [res ""])
             (if (empty? st)
                 res
                 (loop (cdr st) (string-append res (string (list-ref (car st) 0)))))))]
      [(equal? (string-ref s 0) #\()
       (helper (substring s 1) (cons (list (string-ref s 0) idx) stack) (+ idx 1))]
      [(equal? (string-ref s 0) #\))
       (if (empty? stack)
           (helper (substring s 1) stack (+ idx 1))
           (helper (substring s 1) (cdr stack) (+ idx 1)))]
      [else
       (helper (substring s 1) stack (+ idx 1))]))

  (define (remove-invalid s invalid-indices)
    (let loop ([str s] [indices invalid-indices] [res ""] [idx 0])
      (cond
        [(empty? str) res]
        [(member idx indices)
         (loop (substring str 1) indices res (+ idx 1))]
        [else
         (loop (substring str 1) indices (string-append res (string (string-ref str 0))) (+ idx 1))])))

  (define valid-string
    (let loop ([str s] [stack '()] [res ""] [idx 0])
      (cond
        [(empty? str)
         (if (empty? stack)
             res
             (let loop2 ([st stack] [res2 ""] [index 0])
               (cond
                 [(empty? st) res2]
                 [else
                  (loop2 (cdr st) (cons (list-ref (car st) 1) res2) (+ index 1))]))]
        [(equal? (string-ref str 0) #\()
         (loop (substring str 1) (cons (list (string-ref str 0) idx) stack) (string-append res (string (string-ref str 0))) (+ idx 1))]
        [(equal? (string-ref str 0) #\))
         (if (empty? stack)
             (loop (substring str 1) stack res (+ idx 1))
             (loop (substring str 1) (cdr stack) (string-append res (string (string-ref str 0))) (+ idx 1)))]
        [else
         (loop (substring str 1) stack (string-append res (string (string-ref str 0))) (+ idx 1))])))

  (define (find-invalid-indices s)
    (let loop ([str s] [stack '()] [idx 0] [invalid '()])
      (cond
        [(empty? str)
         (if (empty? stack)
             invalid
             (map (lambda (x) (list-ref x 1)) stack))]
        [(equal? (string-ref str 0) #\()
         (loop (substring str 1) (cons (list (string-ref str 0) idx) stack) (+ idx 1) invalid)]
        [(equal? (string-ref str 0) #\))
         (if (empty? stack)
             (loop (substring str 1) stack (+ idx 1) (cons idx invalid))
             (loop (substring str 1) (cdr stack) (+ idx 1) invalid))]
        [else
         (loop (substring str 1) stack (+ idx 1) invalid)])))

  (remove-invalid s (find-invalid-indices s)))