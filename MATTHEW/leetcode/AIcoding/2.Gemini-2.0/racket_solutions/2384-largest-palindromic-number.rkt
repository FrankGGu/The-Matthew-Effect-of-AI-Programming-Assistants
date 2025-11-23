(define (largest-palindromic num)
  (let* ((counts (make-vector 10 0))
         (digits (string->list num)))
    (for-each (lambda (d) (vector-set! counts (- (char->integer d) (char->integer #\0)) (+ (vector-ref counts (- (char->integer d) (char->integer #\0))) 1))) digits)
    (let loop ((i 9) (left "") (middle #f))
      (cond
        ((< i 0)
         (cond
           ((and middle (string=? left "")) (number->string middle))
           ((string=? left "") "0")
           (else
            (string-append left (if middle (number->string middle) "") (string-reverse left)))))
        (else
         (let ((count (vector-ref counts i)))
           (cond
             ((>= count 2)
              (let ((pairs (floor (/ count 2))))
                (vector-set! counts i (- count (* 2 pairs)))
                (loop i (string-append left (make-string pairs (integer->char (+ i (char->integer #\0))))) middle)))
             (else
              (let ((new-middle (cond
                                   ((and (not middle) (> count 0)) i)
                                   (else middle))))
                (loop (- i 1) left new-middle)))))))))