(define (checkMove board row col player)
  (define n (length board))
  (define (in-bounds? r c) (and (>= r 0) (< r n) (>= c 0) (< c n)))
  (define directions '((1 0) (0 1) (1 1) (1 -1) (-1 0) (0 -1) (-1 -1) (-1 1)))

  (for/or ([d directions])
    (let* ([dr (car d)]
           [dc (cadr d)]
           [r (+ row dr)]
           [c (+ col dc)]
           [count 0])
      (for/loop ([i 0] [count count])
        (when (in-bounds? r c)
          (if (equal? (list-ref (list-ref board r) c) player)
              (set! count (+ count 1))
              (set! count 0)))
        (if (> count 2)
            (begin (set! count 3) (return #t)))
        (set! r (+ r dr))
        (set! c (+ c dc))))))

(checkMove board row col player)