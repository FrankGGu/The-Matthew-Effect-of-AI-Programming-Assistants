(define (ladder-length begin-word end-word word-list)
  (let* ([word-set (list->set word-list)]
         [queue (mcons (list begin-word 1) '())]
         [visited (mutable-set)])
    (if (not (set-member? word-set end-word))
        0
        (let loop ()
          (if (null? queue)
              0
              (let* ([current (mcar queue)]
                     [word (car current)]
                     [level (cadr current)]
                     [queue (mcdr queue)])
                (if (equal? word end-word)
                    level
                    (begin
                      (for ([i (in-range (string-length word))])
                        (let* ([chars (string->list word)]
                               [original-char (list-ref chars i)])
                          (for ([c (in-range (char->integer #\a) (add1 (char->integer #\z)))])
                            (let* ([new-chars (list-copy chars)]
                                   [new-char (integer->char c)]
                              (when (not (equal? new-char original-char))
                                (list-set! new-chars i new-char)
                                (let ([new-word (list->string new-chars)])
                                  (when (and (set-member? word-set new-word)
                                            (not (set-member? visited new-word)))
                                    (set-add! visited new-word)
                                    (set! queue (mcons (list new-word (add1 level)) queue)))))))))
                      (loop)))))))))