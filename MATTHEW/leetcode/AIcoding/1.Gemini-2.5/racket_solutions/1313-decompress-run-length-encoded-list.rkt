(define (decompress-rl-encoded-list nums)
  (define (decompress-helper nums result)
    (if (empty? nums)
        result
        (let* ((freq (first nums))
               (val (second nums))
               (new-segment (make-list freq val)))
          (decompress-helper (rest (rest nums)) (append result new-segment)))))
  (decompress-helper nums '()))