(define (balanced-string s)
  (define freq (make-vector 4 0))
  (define n (string-length s))
  (define target (/ n 4))

  (for ([i (in-range n)])
    (vector-set! freq (char->integer (string-ref s i)) 
                 (+ 1 (vector-ref freq (char->integer (string-ref s i))))))

  (define (excess-char-count)
    (define excess 0)
    (for ([i (in-range 4)])
      (when (> (vector-ref freq i) target)
        (set! excess (+ excess (- (vector-ref freq i) target))))
    )
    excess)

  (if (= (excess-char-count) 0) 0
      (let ([left 0]
            [min-length n]
            [count 0]
            [char-count (make-vector 4 0)])
        (for ([right (in-range n)])
          (vector-set! char-count (char->integer (string-ref s right)) 
                       (+ 1 (vector-ref char-count (char->integer (string-ref s right)))))
          (set! count (if (> (vector-ref char-count (char->integer (string-ref s right))) 
                             (vector-ref freq (char->integer (string-ref s right))))
                          (+ count 1) count))
          (while (and (>= count 1) (<= left right))
            (set! min-length (min min-length (+ 1 (- right left))))
            (vector-set! char-count (char->integer (string-ref s left)) 
                         (- (vector-ref char-count (char->integer (string-ref s left))) 1))
            (if (> (vector-ref char-count (char->integer (string-ref s left))) 
                   (vector-ref freq (char->integer (string-ref s left))))
                (set! count (- count 1)))
            (set! left (+ left 1)))
        min-length))))

(balanced-string "QWER")
(balanced-string "QQWE")
(balanced-string "QQQW")
(balanced-string "WWQQ")
(balanced-string "WQQE")