(define (longest-word words)
  (let loop ([sorted-words (sort (map (lambda (w) (string->list w)) words
                                (lambda (a b) (or (< (length a) (length b))
                                                  (and (= (length a) (length b))
                                                       (string<? (list->string a) (list->string b))))))]
             [seen (set)]
             [result ""])
    (if (null? sorted-words)
        result
        (let* ([current (car sorted-words)]
               [current-str (list->string current)]
          (if (or (= (length current) 1)
                  (set-member? seen (list->string (reverse (cdr (reverse current))))))
              (loop (cdr sorted-words)
                    (set-add seen current-str)
                    (if (or (> (length current) (string-length result))
                            (and (= (length current) (string-length result))
                                 (string<? current-str result)))
                        current-str
                        result))
              (loop (cdr sorted-words) seen result))))))