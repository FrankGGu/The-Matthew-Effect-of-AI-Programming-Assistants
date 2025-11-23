(require racket/hash)

(define (earliest-and-latest-rounds n firstPlayer secondPlayer)
  (define memo (make-hash))

  (define (solve current-n p1 p2)
    ;; Ensure p1 < p2 for consistent memoization keys
    (when (> p1 p2)
      (define temp p1)
      (set! p1 p2)
      (set! p2 temp))

    ;; Memoization check
    (define key (list current-n p1 p2))
    (let ((cached (hash-ref memo key #f)))
      (when cached (hash-ref memo key)))

    ;; Base case: p1 and p2 meet in this round
    (when (= (+ p1 p2) (+ current-n 1))
      (hash-set! memo key (cons 1 1))
      (cons 1 1))

    (let* ((min-res +inf.0)
           (max-res -inf.0)
           (next-n (ceiling (/ current-n 2.0))))

      ;; Iterate over possible number of winners from players before p1
      ;; `w-before` is the number of players from `1` to `p1-1` who win their matches.
      ;; The maximum number of matches involving players `1` to `p1-1` is `(floor (/ (sub1 p1) 2))`.
      ;; So `w-before` can range from `0` up to this maximum.
      (for* ((w-before (in-range 0 (add1 (floor (/ (sub1 p1) 2)))))
             ;; Iterate over possible number of winners from players between p1 and p2
             ;; `w-between` is the number of players from `p1+1` to `p2-1` who win their matches.
             ;; The maximum number of matches involving players `p1+1` to `p2-1` is `(floor (/ (sub1 (- p2 p1)) 2))`.
             ;; So `w-between` can range from `0` up to this maximum.
             (w-between (in-range 0 (add1 (floor (/ (sub1 (- p2 p1)) 2))))))
        (let* ((new-p1 (+ w-before 1))
               (new-p2 (+ w-before 1 w-between 1)))

          ;; Ensure the new positions are valid within the next round's player count
          (when (<= new-p2 next-n)
            (let ((res (solve next-n new-p1 new-p2)))
              (set! min-res (min min-res (+ 1 (car res))))
              (set! max-res (max max-res (+ 1 (cdr res))))))))

      (hash-set! memo key (cons min-res max-res))
      (cons min-res max-res)))

  (solve n firstPlayer secondPlayer))