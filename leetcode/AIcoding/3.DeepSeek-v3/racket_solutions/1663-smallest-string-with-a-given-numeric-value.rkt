(define (get-smallest-string n k)
  (let loop ([remaining k]
             [chars '()]
             [left n])
    (if (= left 0)
        (list->string (reverse chars))
        (let* ([max-possible (min 26 (- remaining (- left 1)))]
               [char (integer->char (+ (char->integer #\a) (- max-possible 1)))])
          (loop (- remaining max-possible) (cons char chars) (- left 1))))))