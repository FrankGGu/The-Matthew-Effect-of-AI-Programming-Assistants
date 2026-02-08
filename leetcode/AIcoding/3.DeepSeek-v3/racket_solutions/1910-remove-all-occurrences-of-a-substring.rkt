(define/contract (remove-occurrences s part)
  (-> string? string? string?)
  (let loop ([s s])
    (let ([idx (string-contains s part)])
      (if idx
          (loop (string-append (substring s 0 idx) (substring s (+ idx (string-length part)))))
          s))))