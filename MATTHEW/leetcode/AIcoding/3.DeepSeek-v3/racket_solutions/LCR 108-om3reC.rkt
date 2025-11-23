(define (ladder-length begin-word end-word word-list)
  (let ([word-set (list->set word-list)])
    (if (not (set-member? word-set end-word))
        0
        (let ([queue (mcons (cons begin-word 1) '())]
              [visited (set)])
          (let loop ()
            (if (null? queue)
                0
                (let* ([current (mcar queue)]
                       [word (car current)]
                       [level (cdr current)])
                  (set! queue (mcdr queue))
                  (if (equal? word end-word)
                      level
                      (begin
                        (for ([i (in-range (string-length word))])
                          (let ([chars (string->list word)])
                            (for ([c (in-string "abcdefghijklmnopqrstuvwxyz")])
                              (when (not (equal? c (list-ref chars i)))
                                (let ([new-chars (list-copy chars)])
                                  (list-set! new-chars i c)
                                  (let ([new-word (list->string new-chars)])
                                    (when (and (set-member? word-set new-word)
                                              (not (set-member? visited new-word)))
                                      (set! visited (set-add visited new-word))
                                      (set! queue (append queue (list (cons new-word (+ level 1)))))))))))
                        (loop))))))))))