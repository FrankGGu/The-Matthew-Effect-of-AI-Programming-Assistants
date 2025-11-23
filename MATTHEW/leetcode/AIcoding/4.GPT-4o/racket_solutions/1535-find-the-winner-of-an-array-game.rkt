(define (getWinner arr k)
  (let loop ((current-winner (car arr))
             (count 0)
             (remaining (cdr arr)))
    (if (null? remaining)
        current-winner
        (let ((next (car remaining)))
          (if (> current-winner next)
              (if (>= (+ count 1) k)
                  current-winner
                  (loop current-winner (+ count 1) (cdr remaining)))
              (loop next 1 (cdr remaining)))))))

(getWinner '(2 1 3 5 4 6) 3)