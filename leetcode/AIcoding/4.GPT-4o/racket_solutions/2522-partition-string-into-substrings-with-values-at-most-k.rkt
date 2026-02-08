(define (partition-string s k)
  (define (char->num c)
    (- (char->integer c) (char->integer #\0)))

  (define (value-of-substring str)
    (foldl (lambda (ch acc)
             (+ (* acc 10) (char->num ch)))
           0
           str))

  (define (count-partitions str)
    (define (helper idx count current-value)
      (if (>= idx (string-length str))
          count
          (let* ((ch (string-ref str idx))
                 (new-value (+ (* current-value 10) (char->num ch))))
            (if (<= new-value k)
                (helper (+ idx 1) count new-value)
                (helper (+ idx 1) (+ count 1) (char->num ch))))))
    (helper 0 0 0))

  (count-partitions s))

(partition-string "1234" 34)