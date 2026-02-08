(define (RLEIterator R)
  (define rle-data (list->vector R))
  (define rle-len (vector-length rle-data))

  (define rle-pos (box 0))
  (define current-rem-count (box (if (> rle-len 0) (vector-ref rle-data 0) 0)))

  (define (next n)
    (let loop ((n-needed n))
      (cond
        ((zero? n-needed)
         (vector-ref rle-data (+ (unbox rle-pos) 1)))

        ((>= (unbox rle-pos) rle-len)
         -1)

        ((zero? (unbox current-rem-count))
         (set-box! rle-pos (+ (unbox rle-pos) 2))
         (if (< (unbox rle-pos) rle-len)
             (set-box! current-rem-count (vector-ref rle-data (unbox rle-pos)))
             (set-box! current-rem-count 0))
         (loop n-needed))

        (else
         (let ((can-consume (min n-needed (unbox current-rem-count))))
           (set-box! current-rem-count (- (unbox current-rem-count) can-consume))
           (loop (- n-needed can-consume)))))))
  next)