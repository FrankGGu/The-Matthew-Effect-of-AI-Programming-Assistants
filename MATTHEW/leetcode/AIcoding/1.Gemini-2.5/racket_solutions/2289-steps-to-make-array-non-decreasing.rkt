(define (steps-to-make-array-non-decreasing nums)
  (let* ([n (length nums)]
         [stack (make-vector n)] ; Stores (value . steps_count)
         [stack-idx -1]          ; Top of the stack
         [max-steps 0])

    (define (stack-empty?) (< stack-idx 0))
    (define (stack-push val steps) (set! stack-idx (+ stack-idx 1)) (vector-set! stack stack-idx (cons val steps)))
    (define (stack-pop) (let ([top-val (vector-ref stack stack-idx)]) (set! stack-idx (- stack-idx 1)) top-val))
    (define (stack-top) (vector-ref stack stack-idx))

    (for-each (lambda (num)
                (let ([current-removal-steps 0]) ; Max steps for elements removed by 'num'
                  (let ([num-inherits-steps #f]) ; Flag to indicate if loop broke due to num == s-val

                    (let loop ()
                      (when (not (stack-empty?))
                        (let* ([s-pair (stack-top)]
                               [s-val (car s-pair)]
                               [s-steps (cdr s-pair)])
                          (cond
                            [(< s-val num)
                             (stack-pop)
                             (set! current-removal-steps (max current-removal-steps (+ s-steps 1)))
                             (loop)]
                            [(= s-val num)
                             (stack-pop)
                             (set! current-removal-steps s-steps) ; num inherits s-steps
                             (set! num-inherits-steps #t)
                             ; Break here. If num == s-val, num replaces s-val.
                             ; Its removal steps are tied to s-val's, and we don't need to look further left
                             ; for elements num might remove.
                             ]
                            [(> s-val num)
                             ; Break. s-val is strictly greater, it will remove num.
                             ]))))

                    (let ([dp-val 0])
                      (cond
                        [(stack-empty?)
                         (set! dp-val 0)] ; No element to its left, so 'num' is never removed by a left element.
                        [num-inherits-steps
                         (set! dp-val current-removal-steps)] ; 'num' inherits 's-steps' from the equal element.
                        [else ; stack not empty, and (car (stack-top)) > num
                         ; 'num' is removed by the element at stack-top.
                         ; The number of steps is 1 (for 'num' itself) + max steps of elements 'num' removed.
                         (set! dp-val (if (> current-removal-steps 0)
                                          (+ current-removal-steps 1)
                                          1))]))

                    (stack-push num dp-val)
                    (set! max-steps (max max-steps dp-val))))
              nums)
    max-steps))