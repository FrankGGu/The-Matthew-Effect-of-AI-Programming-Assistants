(define (max-total-fruits fruits start-position k)
  (define n (length fruits))
  (define (get-fruit-at pos)
    (cond
      [(< pos 0) 0]
      [(>= pos n) 0]
      [else (cadr (list-ref fruits pos))]))

  (define (get-pos-index pos)
    (let loop ([i 0])
      (cond
        [(= i n) -1]
        [(= (car (list-ref fruits i)) pos) i]
        [else (loop (+ i 1))])))

  (define fruits-vec (vector))
  (for ([f fruits])
    (vector-push! fruits-vec f))

  (define (solve left right moves)
    (cond
      [(< moves 0) 0]
      [else
       (let* ([left-index (get-pos-index left)]
              [right-index (get-pos-index right)]
              [fruit-left (if (= left-index -1) 0 (cadr (list-ref fruits left-index))))
              [fruit-right (if (= right-index -1) 0 (cadr (list-ref fruits right-index))))
              [total-fruit (let loop ([i left-index] [sum 0])
                             (cond
                               [(= i right-index) (+ sum (if (= right-index -1) 0 (cadr (list-ref fruits right-index))))]
                               [(> i right-index) sum]
                               [(< i 0) sum]
                               [(>= i n) sum]
                               [else (loop (+ i 1) (+ sum (cadr (list-ref fruits i))))]))]
              [dist-left (- start-position left)]
              [dist-right (- right start-position)])
         (if (and (= left-index -1) (= right-index -1))
             0
             (if (<= (+ dist-left dist-right) moves)
                 total-fruit
                 (let ([max-left (let loop ([i left-index] [cur-moves moves] [cur-sum 0])
                                    (cond
                                      [(< i 0) cur-sum]
                                      [(>= i n) cur-sum]
                                      [(= cur-moves 0) cur-sum]
                                      [else
                                       (let ([pos (car (list-ref fruits i))])
                                         (if (<= (+ (abs (- start-position pos)) (abs (- pos right))) cur-moves)
                                             (loop (+ i 1) (- cur-moves (+ (abs (- start-position pos)) (abs (- pos right)))) (+ cur-sum (cadr (list-ref fruits i))))
                                             cur-sum))]))]
                       [max-right (let loop ([i right-index] [cur-moves moves] [cur-sum 0])
                                     (cond
                                       [(< i 0) cur-sum]
                                       [(>= i n) cur-sum]
                                       [(= cur-moves 0) cur-sum]
                                       [else
                                        (let ([pos (car (list-ref fruits i))])
                                          (if (<= (+ (abs (- start-position pos)) (abs (- pos left))) cur-moves)
                                              (loop (- i 1) (- cur-moves (+ (abs (- start-position pos)) (abs (- pos left)))) (+ cur-sum (cadr (list-ref fruits i))))
                                              cur-sum))]))])
                   (max max-left max-right))))))))

  (let ([positions (map car fruits)])
    (let ([min-pos (apply min positions)]
          [max-pos (apply max positions)])
      (solve min-pos max-pos k))))