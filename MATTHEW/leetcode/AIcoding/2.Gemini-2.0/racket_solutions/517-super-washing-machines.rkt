(define (find-min-moves machines)
  (let* ((n (length machines))
         (total-sum (apply + machines))
         (avg (/ total-sum n)))
    (if (not (integer? avg))
        -1
        (let loop ((i 0)
                   (curr-sum 0)
                   (max-moves 0))
          (if (= i n)
              max-moves
              (let* ((diff (- (list-ref machines i) avg))
                     (curr-sum (+ curr-sum diff))
                     (moves (max (abs curr-sum) (abs diff))))
                (loop (+ i 1)
                      curr-sum
                      (max max-moves moves))))))))