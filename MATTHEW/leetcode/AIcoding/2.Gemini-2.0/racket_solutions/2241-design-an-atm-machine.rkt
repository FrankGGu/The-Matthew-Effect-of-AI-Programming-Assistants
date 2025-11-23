(define ATM
  (class object%
    (init-field
     (counts (list 0 0 0 0 0))) ; [20 50 100 200 500]

    (define/public (deposit banknotesCount)
      (set! counts (map + counts banknotesCount))
      void)

    (define/public (withdraw amount)
      (define denominations (list 500 200 100 50 20))
      (define result (list 0 0 0 0 0))
      (define remaining amount)

      (for/list ([i (in-range 5)])
        (define count (list-ref counts i))
        (define denomination (list-ref denominations i))

        (define num-to-take (min count (floor (/ remaining denomination))))
        (set! remaining (- remaining (* num-to-take denomination)))
        (list-set result i num-to-take)
        )

      (if (= remaining 0)
          (begin
            (set! counts (map - counts result))
            result)
          (begin
            #;(displayln "Cannot withdraw")
            '(-1))
          )
      )
    )
  )