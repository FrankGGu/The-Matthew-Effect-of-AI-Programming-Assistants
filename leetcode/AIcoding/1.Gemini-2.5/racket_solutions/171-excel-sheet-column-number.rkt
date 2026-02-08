(define (title-to-number s)
  (let loop ((idx 0) (result 0))
    (if (= idx (string-length s))
        result
        (let* ((char (string-ref s idx))
               (char-val (+ (- (char->integer char) (char->integer #\A)) 1)))
          (loop (+ idx 1) (+ (* result 26) char-val))))))