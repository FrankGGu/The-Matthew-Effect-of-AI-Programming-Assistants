(define (truncate-sentence s k)
  (let* ((words (string-split s))
         (truncated (take words k)))
    (string-join truncated " ")))