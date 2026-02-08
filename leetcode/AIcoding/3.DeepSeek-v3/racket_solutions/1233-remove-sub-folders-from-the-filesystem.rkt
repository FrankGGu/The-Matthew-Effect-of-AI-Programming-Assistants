(define/contract (remove-subfolders folder)
  (-> (listof string?) (listof string?))
  (let* ([sorted-folders (sort folder string<?)]
         [result (list (first sorted-folders))]
         [prev (first sorted-folders)])
    (for ([f (rest sorted-folders)])
      (unless (string-prefix? (string-append f "/") (string-append prev "/"))
        (set! result (cons f result))
        (set! prev f)))
    (reverse result)))