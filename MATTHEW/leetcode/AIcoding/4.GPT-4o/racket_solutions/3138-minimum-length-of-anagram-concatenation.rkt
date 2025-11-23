(define (min-anagram-length s t)
  (define (count-letters str)
    (let loop ((chars (string->list str)) (counts (make-vector 26 0)))
      (if (null? chars)
          counts
          (let ((index (- (char->integer (car chars)) (char->integer #\a))))
            (vector-set! counts index (+ 1 (vector-ref counts index)))
            (loop (cdr chars) counts)))))

  (define s-count (count-letters s))
  (define t-count (count-letters t))

  (define (min-length)
    (for/fold ([min-length 0]) ([i (in-range 26)])
      (if (> (vector-ref s-count i) (vector-ref t-count i))
          (+ min-length (- (vector-ref s-count i) (vector-ref t-count i)))
          min-length)))

  (min-length))

(define (minLengthOfAnagramConcatenation s t)
  (min-anagram-length s t))