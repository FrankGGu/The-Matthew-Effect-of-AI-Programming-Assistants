(define (max-consecutive-answers key k)
  (define (helper s target)
    (define len (string-length s))
    (define (solve left right count)
      (cond
        [(>= right len) count]
        [else
         (let ([curr (string-ref s right)])
           (if (char=? curr target)
               (solve left (+ right 1) count)
               (if (> k 0)
                   (solve left (+ right 1) count)
                   (let ([next-left (let loop ([i left])
                                        (if (char=? (string-ref s i) target)
                                            i
                                            (loop (+ i 1))))])
                     (solve (+ next-left 1) (+ right 1) count)))))])))

    (define (find-max s target)
      (let loop ([left 0] [right 0] [count 0] [max-count 0] [k-used k])
        (cond
          [(>= right (string-length s)) max-count]
          [else
           (let ([curr (string-ref s right)])
             (if (char=? curr target)
                 (loop left (+ right 1) (+ count 1) (max max-count (+ right 1 (- left))) k-used)
                 (if (> k-used 0)
                     (loop left (+ right 1) (+ count 1) (max max-count (+ right 1 (- left))) (- k-used 1))
                     (let loop2 ([i left])
                       (if (char=? (string-ref s i) target)
                           (loop (+ i 1) (+ right 1) (+ count 1) (max max-count (+ right 1 (- (+ i 1)))) 0)
                           (loop2 (+ i 1)))))))])))

    (find-max s target))

  (max (helper key #\T) (helper key #\F)))