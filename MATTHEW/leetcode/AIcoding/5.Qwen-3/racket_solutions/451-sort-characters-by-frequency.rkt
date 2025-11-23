#lang racket

(define/contract (frequency-sort s)
  (-> string? string?)
  (define freq (make-hash))
  (for ([c (in-string s)])
    (hash-set! freq c (+ 1 (hash-ref freq c 0))))
  (define sorted (sort (string->list s) (lambda (a b)
                                          (let ([fa (hash-ref freq a)]
                                                [fb (hash-ref freq b)])
                                            (if (= fa fb)
                                                (> (char->integer a) (char->integer b))
                                                (> fa fb)))))
  (list->string sorted))