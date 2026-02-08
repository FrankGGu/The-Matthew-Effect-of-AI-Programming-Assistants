(define (sum-game num)
  (let* ([n (string-length num)]
         [half (/ n 2)]
         [left-sum 0]
         [left-q 0]
         [right-sum 0]
         [right-q 0])
    (for ([i (in-range n)])
      (if (< i half)
          (let ([c (string-ref num i)])
            (if (char=? c #\?)
                (set! left-q (add1 left-q))
                (set! left-sum (+ left-sum (- (char->integer c) 48)))))
          (let ([c (string-ref num i)])
            (if (char=? c #\?)
                (set! right-q (add1 right-q))
                (set! right-sum (+ right-sum (- (char->integer c) 48)))))))
    (let ([diff (- left-sum right-sum)]
          [q-diff (- left-q right-q)])
      (if (zero? q-diff)
          (not (zero? diff))
          (if (even? q-diff)
              (not (= (* 9 (/ q-diff 2)) diff))
              #t)))))