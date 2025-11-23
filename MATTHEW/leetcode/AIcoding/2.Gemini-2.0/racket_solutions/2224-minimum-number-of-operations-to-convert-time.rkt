(define (convert-time current correct)
  (let* ([current-minutes (+ (* (string->number (substring current 0 2)) 60) (string->number (substring current 3 5)))]
         [correct-minutes (+ (* (string->number (substring correct 0 2)) 60) (string->number (substring correct 3 5)))]
         [diff (- correct-minutes current-minutes)])
    (cond
      [(< diff 0) (+ 1440 diff)]
      [else diff])
    (let loop ([remaining-minutes diff] [operations 0])
      (cond
        [(<= remaining-minutes 0) operations]
        [(>= remaining-minutes 60) (loop (- remaining-minutes 60) (+ operations 1))]
        [(>= remaining-minutes 15) (loop (- remaining-minutes 15) (+ operations 1))]
        [(>= remaining-minutes 5) (loop (- remaining-minutes 5) (+ operations 1))]
        [else (loop (- remaining-minutes 1) (+ operations 1))])))
  )