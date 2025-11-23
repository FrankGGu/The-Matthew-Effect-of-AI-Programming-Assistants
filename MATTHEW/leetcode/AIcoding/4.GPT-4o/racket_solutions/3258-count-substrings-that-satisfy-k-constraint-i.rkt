(define (countSubstrings s k)
  (define (count-valid substr)
    (let loop ((i 0) (count 0))
      (if (>= i (string-length substr))
          count
          (let ((char (string-ref substr i)))
            (loop (+ i 1) (if (<= (count char substr) k) (+ count 1) count))))))
  (define (count char substr)
    (let loop ((i 0) (count 0))
      (if (>= i (string-length substr))
          count
          (loop (+ i 1) (if (eq? (string-ref substr i) char) (+ count 1) count)))))
  (define (count-all substr)
    (let loop ((i 0) (count 0))
      (if (>= i (string-length substr))
          count
          (loop (+ i 1) (+ count (count-valid (substring substr i)))))))
  (count-all s))