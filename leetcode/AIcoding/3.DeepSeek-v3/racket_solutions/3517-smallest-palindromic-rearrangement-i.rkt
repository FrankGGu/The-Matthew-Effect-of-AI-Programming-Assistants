(define (smallest-palindrome s)
  (let* ([counts (make-hash)]
         [len (string-length s)]
         [chars (string->list s)]
         [odd-count 0]
         [half '()])
    (for ([c chars])
      (hash-update! counts c add1 0))
    (for ([(k v) counts])
      (when (odd? v)
        (set! odd-count (add1 odd-count))))
    (when (> odd-count 1)
      (return ""))
    (let ([sorted-keys (sort (hash-keys counts) char<?)])
      (for ([k sorted-keys])
        (let ([v (hash-ref counts k)])
          (set! half (append half (make-list (quotient v 2) k))))))
    (let* ([half-str (list->string half)]
           [rev-half (reverse half)]
           [rev-half-str (list->string rev-half)]
           [middle (if (odd? len)
                       (let ([c #\0])
                         (for ([(k v) counts])
                           (when (odd? v)
                             (set! c k)))
                         (string c))
                       "")])
      (string-append half-str middle rev-half-str))))