(require racket/set)

(define (num-jewels-in-stones jewels stones)
  (let ((jewel-set (list->set (string->list jewels))))
    (for/sum ((stone-char (in-list (string->list stones))))
      (if (set-member? jewel-set stone-char)
          1
          0))))