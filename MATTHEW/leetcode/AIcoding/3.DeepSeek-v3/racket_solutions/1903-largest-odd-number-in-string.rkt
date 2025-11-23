(define/contract (largest-odd-number num)
  (-> string? string?)
  (let loop ([i (sub1 (string-length num))])
    (cond
      [(< i 0) ""]
      [(odd? (- (char->integer (string-ref num i)) (char->integer #\0)))
       (substring num 0 (add1 i))]
      [else (loop (sub1 i))])))