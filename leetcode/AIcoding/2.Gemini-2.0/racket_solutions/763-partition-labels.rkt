(define (partition-labels s)
  (let* ([n (string-length s)]
         [last (make-vector 26 0)]
         [_ (for ([i (in-range n)])
              (vector-set! last (- (char->integer (string-ref s i)) (char->integer #\a)) i))]
         [result '()]
         [start 0]
         [end 0])
    (for ([i (in-range n)])
      (set! end (max end (vector-ref last (- (char->integer (string-ref s i)) (char->integer #\a)))))
      (if (= i end)
          (begin
            (set! result (append result (list (+ 1 (- end start)))))
            (set! start (+ 1 end)))))
    result))