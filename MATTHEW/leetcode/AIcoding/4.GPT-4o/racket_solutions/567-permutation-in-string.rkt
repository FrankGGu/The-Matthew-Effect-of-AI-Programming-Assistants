(define (check-inclusion s1 s2)
  (define (count-char s)
    (define counts (make-vector 26 0))
    (for-each (lambda (c) (vector-set! counts (- (char->integer c) (char->integer #\a)) (+ 1 (vector-ref counts (- (char->integer c) (char->integer #\a))))))
              s)
    counts)

  (define s1-len (string-length s1))
  (define s1-count (count-char s1))

  (define (matches? counts1 counts2)
    (for/and ([i (in-range 26)])
      (= (vector-ref counts1 i) (vector-ref counts2 i))))

  (define s2-count (count-char (substring s2 0 s1-len)))

  (if (matches? s1-count s2-count)
      #t
      (for/fold ([found #f]
                 [start 0]
                 [end s1-len])
                found
        ([i (in-range s1-len (string-length s2))])
        (begin
          (vector-set! s2-count (- (char->integer (string-ref s2 start)) (char->integer #\a)) 
                       (- (vector-ref s2-count (- (char->integer (string-ref s2 start)) (char->integer #\a))) 1))
          (vector-set! s2-count (- (char->integer (string-ref s2 end)) (char->integer #\a)) 
                       (+ (vector-ref s2-count (- (char->integer (string-ref s2 end)) (char->integer #\a))) 1))
          (set! start (+ start 1))
          (set! end (+ end 1))
          (if (matches? s1-count s2-count) #t found)))))