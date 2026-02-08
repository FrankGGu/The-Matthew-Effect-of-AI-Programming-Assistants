(define (paths-with-max-score board-list)
  (define R (length board-list))
  (define C (string-length (car board-list)))
  (define MOD 1000000007)

  (define board (list->vector board-list))

  (define dp (make-vector R))
  (for ([i (in-range R)])
    (vector-set! dp i (make-vector C (cons -1 0))))

  (define (get-char-value char)
    (cond
      [(char=? char #\S) 0]
      [(char=? char #\E) 0]
      [(char=? char #\X) -1]
      [else (- (char->integer char) (char->integer #\0))]))

  (define (get-dp-val r c)
    (if (and (>= r 0) (< r R) (>= c 0) (< c C))
        (vector-ref (vector-ref dp r) c)
        (cons -1 0)))

  (for* ([r (in-range (- R 1) -1 -1)]
         [c (in-range (- C 1) -1 -1)])
    (let* ([current-char (string-ref (vector-ref board r) c)]
           [char-val (get-char-value current-char)])

      (cond
        [(= char-val -1)
         (vector-set! (vector-ref dp r) c (cons -1 0))]

        [(and (= r (- R 1)) (= c (- C 1)))
         (vector-set! (vector-ref dp r) c (cons 0 1))]

        [else
         (let* ([down-dp (get-dp-val (+ r 1) c)]
                [right-dp (get-dp-val r (+ c 1))]
                [diag-dp (get-dp-val (+ r 1) (+ c 1))]
                [possible-prev-states (list down-dp right-dp diag-dp)]
                [max-prev-score -1])

           (for-each (lambda (prev-state)
                       (let ([prev-score (car prev-state)])
                         (when (not (= prev-score -1))
                           (set! max-prev-score (max max-prev-score prev-score)))))
                     possible-prev-states)

           (if (= max-prev-score -1)
               (vector-set! (vector-ref dp r) c (cons -1 0))
               (let* ([current-cell-score (+ max-prev-score char-val)]
                      [total-paths 0])
                 (for-each (lambda (prev-state)
                             (let ([prev-score (car prev-state)]
                                   [prev-count (cdr prev-state)])
                               (when (and (not (= prev-score -1)) (= prev-score max-prev-score))
                                 (set! total-paths (modulo (+ total-paths prev-count) MOD)))))
                           possible-prev-states)
                 (vector-set! (vector-ref dp r) c (cons current-cell-score total-paths)))))])))

  (let* ([final-result (vector-ref (vector-ref dp 0) 0)]
         [final-score (car final-result)]
         [final-paths (cdr final-result)])
    (if (= final-score -1)
        (list 0 0)
        (list final-score final-paths))))