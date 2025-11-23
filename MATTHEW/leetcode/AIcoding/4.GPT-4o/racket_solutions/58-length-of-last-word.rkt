(define (lengthOfLastWord s)
  (let* ((trimmed (string-trim s))
         (words (string-split trimmed " ")))
    (if (null? words)
        0
        (string-length (car (reverse words))))))