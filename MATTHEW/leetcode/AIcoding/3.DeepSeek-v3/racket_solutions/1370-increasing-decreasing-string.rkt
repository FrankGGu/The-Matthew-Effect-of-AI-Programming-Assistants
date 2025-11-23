(define/contract (sort-string s)
  (-> string? string?)
  (let* ([freq (make-hash)]
         [chars (sort (string->list s) char<?)]
         [n (length chars)])
    (for ([c chars])
      (hash-update! freq c add1 0))
    (let loop ([result '()] [asc? #t])
      (if (zero? (hash-count freq))
          (list->string (reverse result))
          (let* ([keys (sort (hash-keys freq) (if asc? char<? char>?))]
                 [new-result (append (reverse keys) result)])
            (for ([k keys])
              (hash-update! freq k sub1)
              (when (zero? (hash-ref freq k))
                (hash-remove! freq k)))
            (loop new-result (not asc?)))))))