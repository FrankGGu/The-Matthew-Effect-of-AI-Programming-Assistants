(define (license-key-formatting s k)
  (let* ([cleaned-s (string-upcase (regexp-replace* #rx"[-]" s ""))]
         [len (string-length cleaned-s)])
    (if (zero? len)
        ""
        (let loop ([i len] [result '()])
          (cond
            [(zero? i)
             (string-join (reverse result) "-")]
            [(< i k)
             (cons (substring cleaned-s 0 i) result)]
            [else
             (loop (- i k) (cons (substring cleaned-s (- i k) i) result))])))))