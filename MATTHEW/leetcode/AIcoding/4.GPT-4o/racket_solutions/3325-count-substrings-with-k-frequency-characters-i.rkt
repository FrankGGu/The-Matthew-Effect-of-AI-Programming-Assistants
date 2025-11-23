(define (countSubstrings s k)
  (define (count-at-most-k-freq s k)
    (define freq (make-vector 26 0))
    (define left 0)
    (define count 0)
    (for ([right (in-range (string-length s))])
      (let* ([char (string-ref s right)]
             [index (- (char->integer char) (char->integer #\a))])
        (vector-set! freq index (+ 1 (vector-ref freq index)))
        (while (> (apply + (map (lambda (n) (if (> n 0) 1 0)) (vector->list freq))) k)
          (let ([left-char (string-ref s left)]
                [left-index (- (char->integer left-char) (char->integer #\a))])
            (vector-set! freq left-index (- (vector-ref freq left-index) 1))
            (set! left (+ left 1))))
        (set! count (+ count (- right left 1)))))
    count)

  (define at-most-k (count-at-most-k-freq s k))
  (define at-most-k-minus-1 (count-at-most-k-freq s (- k 1)))
  (- at-most-k at-most-k-minus-1))

(countSubstrings "abc" 2)