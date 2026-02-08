(define (minimum-cost-to-convert-string source target allowed-conversations)
  (define n (string-length source))
  (define m (string-length target))
  (define dist (make-vector 26 (make-vector 26 1000000000)))

  (for ([i (in-range 26)])
    (vector-set! (vector-ref dist i) i 0))

  (for ([conversation (in-list allowed-conversations)])
    (define start (char->integer (string-ref (car conversation) 0)) (- (char->integer #\a)))
    (define end (char->integer (string-ref (car conversation) 1)) (- (char->integer #\a)))
    (define cost (cadr conversation))
    (vector-set! (vector-ref dist start) end cost))

  (for ([k (in-range 26)])
    (for ([i (in-range 26)])
      (for ([j (in-range 26)])
        (vector-set! (vector-ref dist i) j (min (vector-ref (vector-ref dist i) j) (+ (vector-ref (vector-ref dist i) k) (vector-ref (vector-ref dist k) j))))))

  (define total-cost 0)
  (for ([i (in-range n)])
    (define start (char->integer (string-ref source i)) (- (char->integer #\a)))
    (define end (char->integer (string-ref target i)) (- (char->integer #\a)))
    (define cost (vector-ref (vector-ref dist start) end))
    (if (= cost 1000000000)
        (return -1)
        (set! total-cost (+ total-cost cost))))

  total-cost)