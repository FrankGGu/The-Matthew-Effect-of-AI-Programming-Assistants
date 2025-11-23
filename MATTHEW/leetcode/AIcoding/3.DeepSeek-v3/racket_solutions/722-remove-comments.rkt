(define (remove-comments source)
  (define in-block #f)
  (define buffer "")
  (define result '())
  (for ([line source])
    (define i 0)
    (define n (string-length line))
    (while (< i n)
      (cond
        [(and (not in-block) (< (+ i 1) n) (string=? (substring line i (+ i 2)) "/*"))
         (set! in-block #t)
         (set! i (+ i 2))]
        [(and in-block (< (+ i 1) n) (string=? (substring line i (+ i 2)) "*/"))
         (set! in-block #f)
         (set! i (+ i 2))]
        [(and (not in-block) (< (+ i 1) n) (string=? (substring line i (+ i 2)) "//"))
         (set! i n)]
        [(not in-block)
         (set! buffer (string-append buffer (substring line i (+ i 1))))
         (set! i (+ i 1))]
        [else
         (set! i (+ i 1))]))
    (when (and (not in-block) (not (string=? buffer "")))
      (set! result (cons buffer result))
      (set! buffer "")))
  (reverse result))