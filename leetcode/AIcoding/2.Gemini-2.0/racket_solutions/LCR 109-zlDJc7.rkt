(define (open-lock deadends target)
  (define dead-set (set deadends))
  (define visited (set))
  (define q (make-queue))

  (when (set-member? dead-set "0000")
    (return -1))

  (queue-enqueue! q (cons "0000" 0))
  (set-add! visited "0000")

  (define (neighbors code)
    (define res '())
    (for ((i (in-range 4)))
      (define digit (string-ref code i))
      (define up-digit (integer->char (modulo (+ 1 (char->integer digit) (- (char->integer #\0))) 10)))
      (define down-digit (integer->char (modulo (+ -1 (char->integer digit) (- (char->integer #\0))) 10)))
      (define up-code (string-copy code))
      (define down-code (string-copy code))
      (string-set! up-code i up-digit)
      (string-set! down-code i down-digit)
      (set! res (cons up-code res))
      (set! res (cons down-code res)))
    res)

  (let loop ()
    (if (queue-empty? q)
        -1
        (let ((curr (queue-dequeue! q)))
          (let ((code (car curr)) (steps (cdr curr)))
            (if (string=? code target)
                steps
                (begin
                  (for ((neighbor (in-list (neighbors code))))
                    (unless (or (set-member? dead-set neighbor)
                                  (set-member? visited neighbor))
                      (queue-enqueue! q (cons neighbor (+ 1 steps)))
                      (set-add! visited neighbor)))
                  (loop))))))))