#lang racket

(define (word-break-ii s word-dict)
  (define dict-set (list->hash-set word-dict))
  (define memo (make-hash))

  (define (helper current-s)
    (hash-ref memo current-s
              (lambda ()
                (let* ([n (string-length current-s)]
                       [sentences '()])

                  (when (= n 0)
                    (set! sentences (list "")))

                  (for ([i (in-range 1 (+ n 1))])
                    (let* ([prefix (substring current-s 0 i)]
                           [suffix (substring current-s i n)])
                      (when (hash-has-key? dict-set prefix)
                        (let ([sub-results (helper suffix)])
                          (for ([sub-sentence sub-results])
                            (set! sentences
                                  (cons (if (string=? sub-sentence "")
                                            prefix
                                            (string-append prefix " " sub-sentence))
                                        sentences)))))))
                  (hash-set! memo current-s (reverse sentences))
                  (reverse sentences)))))

  (helper s))

(define (list->hash-set lst)
  (let ([h (make-hash)])
    (for ([item lst])
      (hash-set! h item #t))
    h))