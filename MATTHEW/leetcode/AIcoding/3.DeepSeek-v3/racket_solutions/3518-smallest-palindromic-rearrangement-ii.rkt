(define (smallest-palindrome s)
  (let* ([freq (make-hash)]
         [n (string-length s)]
         [chars (string->list s)]
         [odd-count 0]
         [half '()])
    (for ([c chars])
      (hash-update! freq c add1 0))
    (for ([(k v) freq])
      (when (odd? v)
        (set! odd-count (add1 odd-count))))
    (when (> odd-count 1)
      (return ""))
    (let* ([sorted-keys (sort (hash-keys freq) char<?)]
           [mid-char #f])
      (for ([k sorted-keys])
        (let ([v (hash-ref freq k)])
          (when (odd? v)
            (set! mid-char k)
            (hash-set! freq k (sub1 v)))
          (set! half (append half (make-list (quotient v 2) k)))))
      (let* ([left (list->string half)]
             [right (list->string (reverse half))])
        (if mid-char
            (string-append left (string mid-char) right)
            (string-append left right))))))