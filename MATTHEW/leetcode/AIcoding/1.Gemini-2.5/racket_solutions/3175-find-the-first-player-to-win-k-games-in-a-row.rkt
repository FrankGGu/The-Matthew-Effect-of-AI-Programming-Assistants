#lang racket

(define (find-the-first-player-to-win-k-games-in-a-row arr k)
  (let* ((n (length arr))
         (max-val (apply max arr)))

    (if (>= k n)
        max-val
        (let loop ((front-players arr)
                   (back-players '())
                   (current-winner #f)
                   (consecutive-wins 0))

          (define (normalize-queue fl bl)
            (if (null? fl)
                (if (null? bl)
                    (values '() '())
                    (values (reverse bl) '()))
                (values fl bl)))

          (let-values (((fl bl) (normalize-queue front-players back-players)))
            (let* ((p1 (car fl))
                   (p2 (cadr fl))
                   (winner (if (> p1 p2) p1 p2))
                   (loser (if (> p1 p2) p2 p1)))

              (let ((new-consecutive-wins
                      (if (and (not (eq? current-winner #f))
                               (equal? winner current-winner))
                          (+ consecutive-wins 1)
                          1)))

                (if (>= new-consecutive-wins k)
                    winner
                    (loop (cons winner (cddr fl))
                          (cons loser bl)
                          winner
                          new-consecutive-wins)))))))))