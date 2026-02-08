(define/contract (largest-good-integer num)
  (-> string? string?)
  (let loop ([i 0] [max-good ""])
    (if (>= i (- (string-length num) 2))
        (if (string=? max-good "") max-good max-good)
        (let* ([a (string-ref num i)]
               [b (string-ref num (+ i 1))]
               [c (string-ref num (+ i 2))]
               [current (if (and (char=? a b) (char=? b c))
                           (substring num i (+ i 3))
                           "")])
          (loop (+ i 1) (if (or (string=? current "") 
                                (string<? max-good current))
                            current
                            max-good))))))