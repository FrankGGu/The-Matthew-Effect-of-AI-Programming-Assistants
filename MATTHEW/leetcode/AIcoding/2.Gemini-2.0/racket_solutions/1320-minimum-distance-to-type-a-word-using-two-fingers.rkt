(define (minimum-distance word)
  (define n (string-length word))
  (define dp (make-vector (list n 27 27) +inf.0))
  (vector-set! dp (list 0 26 26) 0)

  (define (get-pos c)
    (let* ((code (- (char->integer c) (char->integer #\A))))
      (list (quotient code 6) (remainder code 6))))

  (define (distance p1 p2)
    (if (= p1 26)
        0
        (let* ((pos1 (get-pos (integer->char (+ (char->integer #\A) p1))))
               (pos2 (get-pos (integer->char (+ (char->integer #\A) p2))))
               (x1 (list-ref pos1 0))
               (y1 (list-ref pos1 1))
               (x2 (list-ref pos2 0))
               (y2 (list-ref pos2 1)))
          (+ (abs (- x1 x2)) (abs (- y1 y2))))))

  (for ([i (in-range n)])
    (let ((c (string-ref word i))
          (curr-char (- (char->integer c) (char->integer #\A))))
      (for ([j (in-range 27)])
        (for ([k (in-range 27)])
          (let ((curr-dist (vector-ref dp (list i j k))))
            (when (< curr-dist +inf.0)
              (vector-set! dp (list (+ i 1) curr-char k) (min (vector-ref dp (list (+ i 1) curr-char k)) (+ curr-dist (distance j curr-char))))
              (vector-set! dp (list (+ i 1) j curr-char) (min (vector-ref dp (list (+ i 1) j curr-char)) (+ curr-dist (distance k curr-char))))))))))

  (let loop ([j (in-range 27)]
             [k (in-range 27)]
             [min-dist +inf.0])
    (if (= j 27)
        min-dist
        (loop (+ j 1) k (min min-dist (vector-ref dp (list n j k))))))
  )