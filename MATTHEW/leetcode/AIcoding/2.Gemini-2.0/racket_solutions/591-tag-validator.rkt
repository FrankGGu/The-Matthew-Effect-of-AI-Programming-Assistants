(define (is-valid-tag-name? tag)
  (and (>= (string-length tag) 1)
       (<= (string-length tag) 9)
       (regexp-match? #rx"^[A-Z]+$" tag)))

(define (is-valid-cdata? s)
  (string=? (substring s 0 9) "<![CDATA["))

(define (tag-validator code)
  (let loop ([code code]
             [tags '()])
    (cond
      [(string=? code "")
       (and (= (length tags) 0) (not (null? tags)))]
      [(is-valid-cdata? code)
       (let ([end-index (string-index code "]]>")]
         (if end-index
             (loop (substring code (+ end-index 3)) tags)
             #f))]
      [(string=? (substring code 0 2) "</")
       (let ([end-index (string-index code ">")]
             [tag (substring code 2 end-index)])
         (if end-index
             (if (and (is-valid-tag-name? tag)
                      (not (null? tags))
                      (string=? (car tags) tag))
                 (loop (substring code (+ end-index 1)) (cdr tags))
                 #f)
             #f))]
      [(string=? (substring code 0 1) "<")
       (let ([end-index (string-index code ">")]
             [tag (substring code 1 end-index)])
         (if end-index
             (cond
               [(string=? (substring tag 0 1) "!")
                (loop (substring code (+ end-index 1)) tags)]
               [(string=? (substring tag 0 1) "?")
                (loop (substring code (+ end-index 1)) tags)]
               [(string=? (substring tag 0 1) "/")
                #f]
               [else
                (let ([space-index (string-index tag " ")])
                  (let ([tag-name (if space-index (substring tag 0 space-index) tag)]
                        [is-closing (string=? (substring tag (string-length tag) (string-length tag)) "/")])
                    (cond
                      [(not (is-valid-tag-name? tag-name)) #f]
                      [is-closing
                       (loop (substring code (+ end-index 1)) tags)]
                      [else
                       (loop (substring code (+ end-index 1)) (cons tag-name tags))]))])])
             #f))]
      [else
       (if (null? tags)
           #f
           (loop (substring code 1) tags))]))
  )