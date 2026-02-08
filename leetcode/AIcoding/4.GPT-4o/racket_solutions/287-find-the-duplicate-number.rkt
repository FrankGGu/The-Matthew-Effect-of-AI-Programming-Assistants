(define (findDuplicate nums)
  (define (helper slow fast)
    (if (equal? slow fast)
        (begin
          (set! slow 0)
          (let loop ()
            (if (not (equal? slow fast))
                (begin
                  (set! slow (list-ref nums slow))
                  (set! fast (list-ref nums fast))
                  (loop))
                slow)))
        (helper (list-ref nums slow) (list-ref nums (list-ref nums fast)))))
  (helper (list-ref nums 0) (list-ref nums 0)))