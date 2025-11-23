(define (longest-common-prefix-length strs)
  (cond
    [(empty? strs) 0]
    [(= (length strs) 1) (string-length (car strs))]
    [else
     (define first-str (car strs))
     (define rest-strs (cdr strs))
     (define first-str-len (string-length first-str))

     (for/fold ([prefix-len 0])
               ([i (in-range first-str-len)])
       (define char-to-match (string-ref first-str i))
       (define all-match?
         (for/and ([s rest-strs])
           (and (< i (string-length s))
                (char=? (string-ref s i) char-to-match))))
       (if all-match?
           (+ prefix-len 1)
           (break prefix-len)))
     ]))