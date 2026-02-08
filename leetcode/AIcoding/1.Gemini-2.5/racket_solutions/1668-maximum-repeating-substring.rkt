(require racket/string)

(define/public (max-repeating-substring sequence word)
  (let loop ((k 0) (current-repeated-word word))
    (if (string-contains? sequence current-repeated-word)
        (loop (+ k 1) (string-append current-repeated-word word))
        k)))