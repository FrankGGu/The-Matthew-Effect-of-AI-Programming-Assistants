#lang racket

(require racket/set)

(define (count-special-characters word)
  (let ([lower-chars (make-set char<?)]
        [upper-chars (make-set char<?)])

    (for ([c (in-string word)])
      (cond
        [(char-lower-case? c) (set-add! lower-chars c)]
        [(char-upper-case? c) (set-add! upper-chars c)]))

    (let ([special-count 0])
      (for ([i (in-range (char->integer #\a) (add1 (char->integer #\z)))])
        (let* ([lc (integer->char i)]
               [uc (char-upcase lc)])
          (when (and (set-contains? lower-chars lc)
                     (set-contains? upper-chars uc))
            (set! special-count (add1 special-count)))))
      special-count)))