(define (convert-time current correct)
  (let* ([current-hours (string->number (substring current 0 2))]
         [current-mins (string->number (substring current 3 5))]
         [correct-hours (string->number (substring correct 0 2))]
         [correct-mins (string->number (substring correct 3 5))]
         [total-current (+ (* current-hours 60) current-mins)]
         [total-correct (+ (* correct-hours 60) correct-mins)]
         [diff (- total-correct total-current)]
         [ops 0])
    (let loop ([remaining diff])
      (cond
        [(>= remaining 60) (loop (- remaining 60)) (set! ops (+ ops 1))]
        [(>= remaining 15) (loop (- remaining 15)) (set! ops (+ ops 1))]
        [(>= remaining 5) (loop (- remaining 5)) (set! ops (+ ops 1))]
        [(>= remaining 1) (loop (- remaining 1)) (set! ops (+ ops 1))]
        [else ops]))))