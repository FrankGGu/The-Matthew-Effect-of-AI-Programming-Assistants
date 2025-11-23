(define (max-score-indices nums)
  (let* ([n (length nums)]
         [total-ones (count (lambda (x) (= x 1)) nums)])
    (let loop ([i 0]
               [remaining-nums nums]
               [current-zeros-left 0]
               [current-ones-right total-ones]
               [max-score -1]
               [result-indices-rev '()])
      (if (> i n)
          (reverse result-indices-rev)
          (let* ([current-score (+ current-zeros-left current-ones-right)]
                 [new-max-score (max max-score current-score)]
                 [new-result-indices-rev (cond
                                           [(> current-score max-score) (list i)]
                                           [(= current-score max-score) (cons i result-indices-rev)]
                                           [else result-indices-rev])])
            (if (null? remaining-nums)
                (loop (+ i 1)
                      '()
                      current-zeros-left
                      current-ones-right
                      new-max-score
                      new-result-indices-rev)
                (let* ([val-at-i (car remaining-nums)]
                       [next-remaining-nums (cdr remaining-nums)]
                       [next-zeros-left (if (= val-at-i 0)
                                            (+ current-zeros-left 1)
                                            current-zeros-left)]
                       [next-ones-right (if (= val-at-i 1)
                                            (- current-ones-right 1)
                                            current-ones-right)])
                  (loop (+ i 1)
                        next-remaining-nums
                        next-zeros-left
                        next-ones-right
                        new-max-score
                        new-result-indices-rev))))))))