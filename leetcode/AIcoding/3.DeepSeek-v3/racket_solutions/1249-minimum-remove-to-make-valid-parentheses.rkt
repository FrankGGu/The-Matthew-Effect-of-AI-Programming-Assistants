(define/contract (min-remove-to-make-valid s)
  (-> string? string?)
  (let* ([s-list (string->list s)]
         [stack '()]
         [to-remove (mutable-set)])
    (for ([i (in-range (length s-list))]
          [c (in-list s-list)])
      (when (char=? c #\( )
        (set! stack (cons i stack)))
      (when (char=? c #\) )
        (if (null? stack)
            (set-add! to-remove i)
            (set! stack (cdr stack)))))
    (for ([i (in-set stack)])
      (set-add! to-remove i)
    (list->string
     (for/list ([i (in-range (length s-list))]
                [c (in-list s-list)]
                #:unless (set-member? to-remove i))
       c))))