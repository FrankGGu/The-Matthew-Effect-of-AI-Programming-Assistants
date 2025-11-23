(define (most-common-word paragraph banned)
  (let* ([normalized (regexp-replace* #px"[!?',;.]" (string-downcase paragraph) " ")]
         [words (string-split normalized)]
         [freq (make-hash)]
         [banned-set (list->set banned)])
    (for ([word words])
      (when (not (set-member? banned-set word))
      (hash-update! freq word add1 0))
    (let ([max-count 0]
          [result ""])
      (hash-for-each freq (lambda (k v)
                            (when (and (> v max-count) (not (set-member? banned-set k)))
                              (set! max-count v)
                              (set! result k))))
      result)))