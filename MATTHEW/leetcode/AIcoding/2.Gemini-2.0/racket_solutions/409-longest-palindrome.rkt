(define (longest-palindrome s)
  (define (expand-around-center s left right)
    (let loop ([l left] [r right])
      (cond
        [(or (< l 0) (>= r (string-length s))) (substring s (+ l 1) r)]
        [(char=? (string-ref s l) (string-ref s r)) (loop (- l 1) (+ r 1))]
        [else (substring s (+ l 1) r)])))

  (let loop ([i 0] [longest ""])
    (if (>= i (string-length s))
        longest
        (let* ([odd-palindrome (expand-around-center s i i)]
               [even-palindrome (expand-around-center s i (+ i 1))]
               [current-palindrome (if (> (string-length odd-palindrome) (string-length even-palindrome))
                                        odd-palindrome
                                        even-palindrome)])
          (loop (+ i 1) (if (> (string-length longest) (string-length current-palindrome))
                             longest
                             current-palindrome))))))