(define/contract (dynamic-password password shift)
  (-> string? exact-integer? string?)
  (let* ([len (string-length password)]
         [shift (modulo shift len)]
         [part1 (substring password shift len)]
         [part2 (substring password 0 shift)])
    (string-append part1 part2)))