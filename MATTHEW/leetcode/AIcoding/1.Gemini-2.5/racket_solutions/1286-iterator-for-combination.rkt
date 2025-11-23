#lang racket/base

(define CombinationIterator
  (class object
    (init (characters string?) (combinationLength integer?))

    (define combinations (list))
    (define current-index 0)

    (define (generate-combinations chars k)
      (define results (list))
      (define (backtrack current-combo start-idx remaining-k)
        (when (= remaining-k 0)
          (set! results (cons (list->string (reverse current-combo)) results)))
        (when (> remaining-k 0)
          (for ([i (in-range start-idx (length chars))])
            (backtrack (cons (list-ref chars i) current-combo)
                       (+ i 1)
                       (- remaining-k 1)))))
      (backtrack '() 0 k)
      (sort results string<?))

    (set! combinations (generate-combinations (string->list characters) combinationLength))

    (define/public (next)
      (define result (list-ref combinations current-index))
      (set! current-index (+ current-index 1))
      result)

    (define/public (hasNext)
      (< current-index (length combinations)))

    (super-new)))