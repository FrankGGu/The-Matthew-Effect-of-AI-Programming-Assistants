(define (calculate s)
  (let* ([s-list (string->list s)]
         [len (string-length s)]
         [i 0]
         [current-result 0]
         [current-sign 1]
         [current-num 0]
         [stack '()])

    (let loop ()
      (cond
        [(>= i len)
         (+ current-result (* current-sign current-num))]

        [else
         (let ([char (list-ref s-list i)])
           (cond
             [(char-numeric? char)
              (set! current-num (+ (* current-num 10) (- (char->integer char) (char->integer #\0))))
              (set! i (+ i 1))
              (loop)]
             [else
              (set! current-result (+ current-result (* current-sign current-num)))
              (set! current-num 0)
              (set! i (+ i 1))

              (cond
                [(char=? char #\+)
                 (set! current-sign 1)
                 (loop)]
                [(char=? char #\-)
                 (set! current-sign -1)
                 (loop)]
                [(char=? char #\()
                 (set! stack (cons (list current-result current-sign) stack))
                 (set! current-result 0)
                 (set! current-sign 1)
                 (loop)]
                [(char=? char #\))
                 (let* ([prev-state (car stack)]
                        [prev-result (car prev-state)]
                        [prev-sign (cadr prev-state)])
                   (set! stack (cdr stack))
                   (set! current-result (+ prev-result (* prev-sign current-result)))
                   (set! current-sign 1)
                   (loop))]
                [(char=? char #\ )
                 (loop)]
                [else (error "Invalid character")]))])))))