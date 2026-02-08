(require racket/set)

(define (fair-candy-swap aliceSizes bobSizes)
  (define sumA (apply + aliceSizes))
  (define sumB (apply + bobSizes))
  (define diff (/ (- sumA sumB) 2))

  (define bob-set (list->set bobSizes))

  (for/first ([x (in-list aliceSizes)])
    (define y (- x diff))
    (when (set-member? bob-set y)
      (list x y))))