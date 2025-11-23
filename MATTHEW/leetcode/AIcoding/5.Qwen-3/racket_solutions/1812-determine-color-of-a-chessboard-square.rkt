(define (num-colors)
  (let ((n (read)))
    (if (not n) 0
        (+ (if (= (modulo n 2) 0) 1 0)
           (num-colors)))))

(define (main)
  (let ((input (read-line)))
    (if (not input) #f
        (let ((row (string-ref input 0))
              (col (string->number (substring input 1))))
          (if (or (not (char-numeric? row)) (not (integer? col))) #f
              (let ((r (if (char=? row #\a) 0
                          (if (char=? row #\b) 1
                              (if (char=? row #\c) 2
                                  (if (char=? row #\d) 3
                                      (if (char=? row #\e) 4
                                          (if (char=? row #\f) 5
                                              (if (char=? row #\g) 6
                                                  (if (char=? row #\h) 7 8)))))))))
                (if (even? (+ r col)) "black" "white")))))))

(main)