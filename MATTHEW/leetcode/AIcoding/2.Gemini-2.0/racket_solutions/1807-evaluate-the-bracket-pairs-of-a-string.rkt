(define (evaluate-bracket-pairs s knowledge)
  (let* ([knowledge-hash (make-hash)]
         [_ (for ([pair (in-list knowledge)])
              (hash-set! knowledge-hash (car pair) (cadr pair)))]
         [result (string-builder)]
         [i (box 0)]
         [n (string-length s)])
    (let loop ()
      (if (= (unbox i) n)
          (string-builder-string result)
          (let ([char (string-ref s (unbox i))])
            (if (char=? char #\()
                (let loop2 ([j (+ (unbox i) 1)])
                  (if (= j n)
                      (begin
                        (string-builder-append result "(")
                        (set-box! i (+ (unbox i) 1))
                        (loop))
                      (let ([char2 (string-ref s j)])
                        (if (char=? char2 #\))
                            (let ([key (substring s (+ (unbox i) 1) j)])
                              (let ([value (hash-ref knowledge-hash key #"?")])
                                (string-builder-append result value)
                                (set-box! i (+ j 1))
                                (loop)))
                            (loop2 (+ j 1))))))
                (begin
                  (string-builder-append result (string char))
                  (set-box! i (+ (unbox i) 1))
                  (loop))))))))