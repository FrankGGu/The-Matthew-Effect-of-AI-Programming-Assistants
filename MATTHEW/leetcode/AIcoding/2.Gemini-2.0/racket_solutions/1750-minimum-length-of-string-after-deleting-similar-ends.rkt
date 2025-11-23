(define (minimum-length s)
  (let loop ([l 0] [r (- (string-length s) 1)])
    (cond
      [(>= l r) (- r l 1)]
      [else
       (let ([cl (string-ref s l)] [cr (string-ref s r)])
         (if (char=? cl cr)
             (let loop2 ([nl (+ l 1)])
               (cond
                 [(= nl r) (loop (+ nl 1) (- r 1))]
                 [(char=? cl (string-ref s nl)) (loop2 (+ nl 1))]
                 [else (let loop3 ([nr (- r 1)])
                         (cond
                           [(= nr l) (loop (+ l 1) (- nr 1))]
                           [(char=? cr (string-ref s nr)) (loop3 (- nr 1))]
                           [else (loop nl nr)]))]))
             (- r l 1)))])))