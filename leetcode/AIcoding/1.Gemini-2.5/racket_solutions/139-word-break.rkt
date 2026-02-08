(require racket/set)

(define (word-break s wordDict)
  (define n (string-length s))
  (define dp (make-vector (+ n 1) #f))
  (define word-set (list->set wordDict))

  (vector-set! dp 0 #t)

  (for ([i (in-range 1 (+ n 1))])
    (for ([j (in-range i)])
      (when (vector-ref dp j)
        (define current-word (substring s j i))
        (when (set-member? word-set current-word)
          (vector-set! dp i #t)
          (break)))))

  (vector-ref dp n))