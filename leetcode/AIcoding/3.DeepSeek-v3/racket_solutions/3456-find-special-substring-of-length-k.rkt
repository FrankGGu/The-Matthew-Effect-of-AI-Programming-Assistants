(define/contract (find-special-substring s k)
  (-> string? exact-positive-integer? string?)
  (let loop ([i 0])
    (if (> (+ i k) (string-length s))
        ""
        (let ([substr (substring s i (+ i k))])
          (if (special? substr)
              substr
              (loop (+ i 1)))))))

(define/contract (special? s)
  (-> string? boolean?)
  ;; 实现特殊条件的检查
  #t)