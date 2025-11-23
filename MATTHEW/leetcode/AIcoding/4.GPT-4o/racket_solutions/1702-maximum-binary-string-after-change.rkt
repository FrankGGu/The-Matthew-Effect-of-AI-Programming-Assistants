(define (maximumBinaryString binary)
  (define ones (count (lambda (c) (equal? c #\1)) binary))
  (if (= ones (string-length binary))
      binary
      (string-append (make-string ones #\1) (make-string (- (string-length binary) ones 1) #\0))))

(define (maximumBinaryString-main)
  (define input (read-line))
  (maximumBinaryString input))

(maximumBinaryString-main)