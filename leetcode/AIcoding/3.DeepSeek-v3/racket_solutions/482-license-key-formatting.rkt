(define (license-key-formatting s k)
  (let* ([s (string-upcase s)]
         [s (string-replace s "-" "")]
         [len (string-length s)]
         [first-group (remainder len k)]
         [result (string-append (substring s 0 first-group))])
    (if (zero? first-group)
        (string-join (for/list ([i (in-range 0 len k)])
                       (substring s i (+ i k))) "-")
        (string-join (cons result (for/list ([i (in-range first-group len k)])
                                    (substring s i (+ i k)))) "-"))))