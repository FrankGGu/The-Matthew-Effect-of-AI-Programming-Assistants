(define (rotate-the-box box)
  (let* ((M (length box))
         (N (length (car box))))

    (define rotated-box-pre-gravity
      (build-list N
        (lambda (new-row-idx)
          (build-list M
            (lambda (new-col-idx)
              (list-ref (list-ref box (- M 1 new-col-idx)) new-row-idx)
            )
          )
        )
      )
    )

    (map
      (lambda (row)
        (let* ((num-stones (count (lambda (c) (char=? c #\#)) row))
               (num-empty (- M num-stones)))
          (append (make-list num-empty #\.) (make-list num-stones #\#))
        )
      )
      rotated-box-pre-gravity
    )
  )
)