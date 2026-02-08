(define (count-good-integers low high k)
  (define (count n)
    (define (digit-dp pos tight sum digits memo)
      (if (= pos (vector-length digits))
          (if (= (modulo sum k) 0) 1 0)
          (let ([key (list pos tight sum)])
            (if (hash-has-key? memo key)
                (hash-ref memo key)
                (let* ([limit (if tight (vector-ref digits pos) 9)]
                       [res 0])
                  (for ([d (in-range 0 (+ limit 1))]
                    (set! res (+ res (digit-dp (+ pos 1)
                                              (and tight (= d limit))
                                              (+ sum d)
                                              digits
                                              memo)))
                  (hash-set! memo key res)
                  res)))))
    (let* ([digits (list->vector (map (lambda (c) (- (char->integer c) (char->integer #\0))) 
                                     (string->list (number->string n)))]
           [memo (make-hash)])
      (digit-dp 0 #t 0 digits memo)))
  (- (count high) (count (- low 1))))