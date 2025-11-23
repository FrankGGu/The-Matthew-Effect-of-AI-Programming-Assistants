(define (alternating-groups s)
  (let* ([n (string-length s)]
         [groups (list)]
         [current-group (string (string-ref s 0))]
         [current-group-type (string-ref s 0)])
    (for ([i (in-range 1 n)])
      (let ([char (string-ref s i)])
        (if (char=? char current-group-type)
            (set! current-group (string-append current-group (string char)))
            (begin
              (set! groups (append groups (list current-group)))
              (set! current-group (string char))
              (set! current-group-type char)))))
    (set! groups (append groups (list current-group)))
    groups))