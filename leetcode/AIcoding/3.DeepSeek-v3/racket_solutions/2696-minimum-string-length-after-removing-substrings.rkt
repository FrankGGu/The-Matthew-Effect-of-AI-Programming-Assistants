(define (min-length s)
  (let loop ([str s])
    (let ([ab-pos (regexp-match-positions "AB" str)]
          [cd-pos (regexp-match-positions "CD" str)])
      (cond
        [(or ab-pos cd-pos)
         (let* ([pos (if ab-pos ab-pos cd-pos)]
                [new-str (string-append (substring str 0 (caar pos))
                                        (substring str (cdar pos) (string-length str)))])
           (loop new-str))]
        [else (string-length str)]))))