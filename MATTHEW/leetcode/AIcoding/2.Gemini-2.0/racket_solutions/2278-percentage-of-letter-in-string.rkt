(define (percentage-letter s letter)
  (let ((count 0)
        (len (string-length s)))
    (for ([i (in-range len)])
      (when (char=? (string-ref s i) letter)
        (set! count (+ count 1))))
    (if (= len 0)
        0
        (floor (* 100 (/ count len))))))