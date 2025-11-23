#lang racket

(define (min-stickers stickers target)
  (define n (string-length target))
  (define target-chars (make-hash))
  (for ([c (in-string target)])
    (hash-update! target-chars c add1 0))

  (define sticker-chars-list
    (for/list ([sticker (in-list stickers)])
      (define h (make-hash))
      (for ([c (in-string sticker)])
        (hash-update! h c add1 0))
      h))

  (define memo (make-hash))

  (define (dfs remaining)
    (if (zero? remaining)
        0
        (if (hash-has-key? memo remaining)
            (hash-ref memo remaining)
            (let ([res +inf.0])
              (for ([sticker (in-list sticker-chars-list)])
                (define next-remaining remaining)
                (define used? #f)
                (define tmp-hash (make-hash))
                (for ([(c cnt) (in-hash target-chars)])
                  (define have (hash-ref sticker c 0))
                  (define need (bitwise-and remaining (arithmetic-shift 1 cnt)))
                  (when (positive? need)
                    (define use (min have need))
                    (when (positive? use)
                      (set! used? #t)
                      (hash-set! tmp-hash c use)
                      (set! next-remaining
                            (bitwise-and next-remaining
                                         (bitwise-not (arithmetic-shift 1 (- cnt use))))))))
                (when used?
                  (set! res (min res (add1 (dfs next-remaining)))))
              (hash-set! memo remaining (if (infinite? res) -1 res))
              (hash-ref memo remaining)))))

  (define initial-remaining
    (for/fold ([res 0])
              ([(c cnt) (in-hash target-chars)]
              [i (in-naturals 0)])
      (bitwise-ior res (arithmetic-shift 1 cnt))))

  (define ans (dfs initial-remaining))
  (if (equal? ans +inf.0) -1 ans))