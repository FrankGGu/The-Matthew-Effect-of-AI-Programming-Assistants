#lang racket

(require racket/string)
(require racket/set)

(define (find-valid-emails emails)
  (define (normalize-email email)
    (let* ([parts (string-split email "@")]
           [local-name (first parts)]
           [domain-name (second parts)]
           [plus-index (string-index-of local-name "+")]
           [processed-local-name
             (let* ([local-without-plus
                       (if plus-index
                           (substring local-name 0 plus-index)
                           local-name)])
               (string-replace-all local-without-plus "." ""))]
           )
      (string-append processed-local-name "@" domain-name)))

  (set->list (list->set (map normalize-email emails))))