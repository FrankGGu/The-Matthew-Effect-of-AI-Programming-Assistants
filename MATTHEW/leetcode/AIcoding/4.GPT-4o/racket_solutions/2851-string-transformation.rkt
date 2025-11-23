(define (canTransform start end)
  (define (valid? s)
    (and (string? s) (= (string-length s) 6)))

  (define (moveL s)
    (if (string-contains? s "L")
        (string-append (substring s 1 (string-length s))
                       "L")
        s))

  (define (moveR s)
    (if (string-contains? s "R")
        (string-append "R" (substring s 0 (- (string-length s) 1)))
        s))

  (define (transform s1 s2)
    (cond
      [(string=? s1 s2) #t]
      [(< (string-length s1) (string-length s2)) #f]
      [else (transform (moveL s1) (moveL s2))]))

  (and (valid? start) (valid? end) (transform start end))
)

(canTransform "RXXLRXRXL" "XRLXXRRLX")