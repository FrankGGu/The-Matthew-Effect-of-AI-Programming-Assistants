(define (min-stickers stickers target)
  (define (count-chars str)
    (let loop ((chars (string->list str)) (count (make-vector 26 0)))
      (if (null? chars)
          count
          (let* ((char (car chars))
                 (index (- (char->integer char) (char->integer #\a))))
            (vector-set! count index (+ 1 (vector-ref count index)))
            (loop (cdr chars) count)))))

  (define sticker-count (map count-chars stickers))
  (define target-count (count-chars target))

  (define (dp target-count)
    (define (helper count)
      (if (vector-every? zero? count)
          0
          (define results
            (for/fold ([res +inf.0]) ([sticker sticker-count])
              (define new-count (vector-copy count))
              (for ((i (in-range 26)))
                (vector-set! new-count i (max 0 (- (vector-ref new-count i) (vector-ref sticker i)))))
              (if (vector-every? zero? new-count)
                  (min res 1)
                  (min res (+ 1 (helper new-count)))))))
      results))

  (helper target-count))

(define (minStickers stickers target)
  (min-stickers stickers target))