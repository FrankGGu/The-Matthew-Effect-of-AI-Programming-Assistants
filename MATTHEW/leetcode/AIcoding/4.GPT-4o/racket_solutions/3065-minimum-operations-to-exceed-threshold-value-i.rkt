(define (min-operations nums x)
  (define total (apply + nums))
  (define target (- total x))
  (define n (length nums))
  (define max-length -1)

  (define (find-max-length start end sum)
    (if (>= sum target)
        (begin
          (set! max-length (max max-length (- end start)))
          (find-max-length start (+ end 1) (+ sum (if (< end n) (list-ref nums end) 0)))
        )
        (if (< end n)
            (find-max-length start (+ end 1) (+ sum (list-ref nums end)))
            (if (< start n)
                (find-max-length (+ start 1) end (- sum (list-ref nums start)))
                max-length
            )
        )
    )
  )

  (find-max-length 0 0 0)
  (if (= max-length -1)
      -1
      (- n max-length)))