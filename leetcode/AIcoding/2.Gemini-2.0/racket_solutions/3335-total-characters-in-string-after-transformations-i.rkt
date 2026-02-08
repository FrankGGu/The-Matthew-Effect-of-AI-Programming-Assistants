(define (character-replacement s k)
  (let ([n (string-length s)])
    (if (zero? n)
        0
        (let loop ([left 0] [right 0] [max-freq 0] [counts (make-vector 26 0)])
          (if (= right n)
              (- right left)
              (let* ([char (string-ref s right)]
                     [index (- (char->integer char) (char->integer #\A))]
                     [new-counts (vector-set! counts index (+ 1 (vector-ref counts index)))]
                     [new-max-freq (max max-freq (vector-ref counts index))])
                (if (> (- right left new-max-freq) k)
                    (let* ([left-char (string-ref s left)]
                           [left-index (- (char->integer left-char) (char->integer #\A))])
                      (vector-set! counts left-index (- (vector-ref counts left-index) 1))
                      (loop (+ 1 left) (+ 1 right) new-max-freq counts))
                    (loop left (+ 1 right) new-max-freq counts))))))))