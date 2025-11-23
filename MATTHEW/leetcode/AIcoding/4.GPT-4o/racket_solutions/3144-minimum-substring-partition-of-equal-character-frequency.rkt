(define (minSubstringPartition s)
  (define (is-valid freq)
    (and (not (zero? (first freq)))
         (apply = (filter (lambda (x) (> x 0)) freq))))

  (define (count-freq s)
    (let loop ((i 0) (freq (make-vector 26 0)))
      (if (< i (string-length s))
          (begin
            (vector-set! freq (- (char->integer (string-ref s i)) (char->integer #\a)) 1)
            (loop (+ i 1) freq))
          freq)))

  (define (helper start end)
    (if (>= end (string-length s))
        (if (is-valid (count-freq (substring s start end)))
            (- end start)
            +inf.0)
        (let ((len1 (if (is-valid (count-freq (substring s start end)))
                       (- end start)
                       +inf.0))
              (len2 (helper start (+ end 1))))
          (min len1 len2))))

  (let ((result (helper 0 1)))
    (if (= result +inf.0) -1 result)))

(minSubstringPartition "aabbcc")