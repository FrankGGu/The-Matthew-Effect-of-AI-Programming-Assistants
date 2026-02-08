(require racket/string)

(define/contract (extract-spell words separator)
  (-> (listof string?) string? (listof string?))
  (let ((sep-char (string-ref separator 0)))
    (append-map
     (lambda (word)
       (filter (lambda (s) (not (string=? s "")))
               (string-split word sep-char)))
     words)))