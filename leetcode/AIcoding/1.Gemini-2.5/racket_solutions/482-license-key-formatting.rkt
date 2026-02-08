(define (license-key-formatting s k)
  (define cleaned-s
    (string-upcase
     (list->string
      (filter (lambda (c) (not (char=? c #\-))) (string->list s)))))

  (define n (string-length cleaned-s))

  (if (= n 0)
      ""
      (let* ((first-group-len (remainder n k))
             (result-parts '())
             (current-idx 0))

        (when (= first-group-len 0)
          (set! first-group-len k))

        (set! result-parts (cons (substring cleaned-s current-idx (+ current-idx first-group-len)) result-parts))
        (set! current-idx (+ current-idx first-group-len))

        (let loop ()
          (when (< current-idx n)
            (set! result-parts (cons "-" result-parts))
            (set! result-parts (cons (substring cleaned-s current-idx (+ current-idx k)) result-parts))
            (set! current-idx (+ current-idx k))
            (loop)))

        (string-append (reverse result-parts)))))