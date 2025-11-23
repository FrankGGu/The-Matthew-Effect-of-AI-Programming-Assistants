(define (max-product words)
  (let* ([n (length words)]
         [word-data-vec (make-vector n)]
         [max-prod 0])

    (for ([i (in-range n)]
          [word words])
      (let ([mask 0]
            [len (string-length word)])
        (for ([char (string->list word)])
          (set! mask (bitwise-ior mask (arithmetic-shift 1 (- (char->integer char) (char->integer #\a))))))
        (vector-set! word-data-vec i (cons mask len))))

    (for ([i (in-range n)])
      (for ([j (in-range (+ i 1) n)])
        (let* ([data-i (vector-ref word-data-vec i)]
               [mask-i (car data-i)]
               [len-i (cdr data-i)]
               [data-j (vector-ref word-data-vec j)]
               [mask-j (car data-j)]
               [len-j (cdr data-j)])
          (when (= (bitwise-and mask-i mask-j) 0)
            (set! max-prod (max max-prod (* len-i len-j)))))))
    max-prod))