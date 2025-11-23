(define (longest-common-prefix strs)
  (cond
    [(empty? strs) ""]
    [(= (length strs) 1) (car strs)]
    [else
     (let* ([first-str (car strs)]
            [rest-strs (cdr strs)]
            [len-first-str (string-length first-str)])

       (define (find-lcp-at-index current-idx)
         (cond
           [(= current-idx len-first-str)
            (substring first-str 0 current-idx)]
           [else
            (let ([char-to-match (string-ref first-str current-idx)])
              (if (for/and ([s rest-strs])
                    (and (> (string-length s) current-idx)
                         (char=? (string-ref s current-idx) char-to-match)))
                  (find-lcp-at-index (+ current-idx 1))
                  (substring first-str 0 current-idx)))]))

       (find-lcp-at-index 0))]))