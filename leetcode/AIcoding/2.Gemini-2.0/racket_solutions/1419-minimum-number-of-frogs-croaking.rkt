(define (min-number-of-frogs croaks)
  (let ([c-count 0]
        [r-count 0]
        [o-count 0]
        [a-count 0]
        [k-count 0]
        [frogs-in-use 0]
        [min-frogs 0])
    (for ([char (string->list croaks)])
      (cond
        [(char=? char #\c) (begin (set! c-count (+ c-count 1))
                                  (set! frogs-in-use (+ frogs-in-use 1))
                                  (set! min-frogs (max min-frogs frogs-in-use)))]
        [(char=? char #\r) (begin (set! r-count (+ r-count 1))
                                  (set! c-count (- c-count 1))
                                  (when (< c-count 0) (return -1)))]
        [(char=? char #\o) (begin (set! o-count (+ o-count 1))
                                  (set! r-count (- r-count 1))
                                  (when (< r-count 0) (return -1)))]
        [(char=? char #\a) (begin (set! a-count (+ a-count 1))
                                  (set! o-count (- o-count 1))
                                  (when (< o-count 0) (return -1)))]
        [(char=? char #\k) (begin (set! k-count (+ k-count 1))
                                  (set! a-count (- a-count 1))
                                  (set! frogs-in-use (- frogs-in-use 1))
                                  (when (< a-count 0) (return -1)))]
        [else (return -1)]))
    (if (and (= c-count 0) (= r-count 0) (= o-count 0) (= a-count 0) (= k-count 0))
        min-frogs
        -1)))