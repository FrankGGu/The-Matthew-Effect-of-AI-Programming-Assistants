#lang racket

(define combination-iterator%
  (class object%
    (super-new)
    (init-field chars combinationLength)

    (define combinations '())
    (define current-index 0)

    (define (generate-combinations start path)
      (if (= (length path) combinationLength)
          (set! combinations (cons (list->string (reverse path)) combinations))
          (for ([i (in-range start (length chars))])
            (generate-combinations (+ i 1) (cons (list-ref chars i) path))))

    (generate-combinations 0 '())
    (set! combinations (reverse combinations))

    (define/public (next)
      (define result (list-ref combinations current-index))
      (set! current-index (+ current-index 1))
      result)

    (define/public (hasNext)
      (< current-index (length combinations)))))