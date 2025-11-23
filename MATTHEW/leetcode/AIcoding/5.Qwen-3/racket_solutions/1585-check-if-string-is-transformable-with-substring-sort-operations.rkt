(define (is-transformable s t)
  (define (count-positions c)
    (let ((cnt (make-vector 10 0)))
      (for-each (lambda (ch) (vector-set! cnt (- (char->integer ch) 48) (+ (vector-ref cnt (- (char->integer ch) 48)) 1))) s)
      cnt))
  (define (get-min-index pos)
    (let loop ((i 0))
      (if (= i 10) -1
          (if (> (vector-ref pos i) 0) i
              (loop (+ i 1)))))
  (define (update-pos pos ch)
    (vector-set! pos (- (char->integer ch) 48) (- (vector-ref pos (- (char->integer ch) 48)) 1)))
  (let ((pos (count-positions t)))
    (for-each (lambda (ch) (update-pos pos ch)) t)
    (let loop ((i 0))
      (if (= i (string-length s))
          #t
          (let ((c (string-ref s i)))
            (let ((min-idx (get-min-index pos)))
              (if (= min-idx -1) #f
                  (if (= (char->integer c) min-idx) (loop (+ i 1))
                      #f))))))))