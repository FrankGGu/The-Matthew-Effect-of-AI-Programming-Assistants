(require racket/set)
(require racket/list)

(define (relocate-marbles nums moveFrom moveTo)
  (let* ([current-positions (list->set nums)]
         [final-positions
          (for/fold ([acc-set current-positions])
                    ([from moveFrom]
                     [to moveTo])
            (set-add (set-remove acc-set from) to))])
    (sort (set->list final-positions) <)))