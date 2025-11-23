(define/contract (word-pattern pattern s)
  (-> string? string? boolean?)
  (let* ([pattern-list (string->list pattern)]
         [words (string-split s)])
    (if (not (= (length pattern-list) (length words)))
        #f
        (let ([pattern-to-word (make-hash)]
              [word-to-pattern (make-hash)])
          (for/and ([p pattern-list]
                    [w words])
            (let ([current-pattern (hash-ref pattern-to-word p #f)]
                  [current-word (hash-ref word-to-pattern w #f)])
              (cond
                [(and (not current-pattern) (not current-word))
                 (hash-set! pattern-to-word p w)
                 (hash-set! word-to-pattern w p)
                 #t]
                [(and current-pattern current-word)
                 (and (equal? current-pattern w) (equal? current-word p))]
                [else #f])))))))