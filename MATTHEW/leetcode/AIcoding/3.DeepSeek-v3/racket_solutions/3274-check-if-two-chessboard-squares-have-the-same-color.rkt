(define/contract (square-is-white coordinates)
  (-> string? boolean?)
  (let* ([x (char->integer (string-ref coordinates 0))]
         [y (char->integer (string-ref coordinates 1))])
    (not (even? (+ (- x (char->integer #\a)) (- y (char->integer #\1)))))))