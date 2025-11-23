(define (min-window s t)
  (define (update-count count char delta)
    (if (equal? char #\space)
        count
        (let ((new-count (hash-ref count char 0)))
          (hash-set! count char (+ new-count delta)))))

  (define t-count (make-hash))
  (for-each (lambda (char) (update-count t-count char 1)) (string->list t))

  (define s-count (make-hash))
  (define left 0)
  (define min-len +inf.0)
  (define min-start 0)
  (define have 0)
  (define need (hash-count t-count))

  (for ([right (in-range (string-length s))])
    (let* ([char (string-ref s right)]
           [count (hash-ref s-count char 0)])
      (update-count s-count char 1)
      (when (and (hash-ref t-count char #f) 
                 (<= (+ count 1) (hash-ref t-count char)))
        (set! have (+ have 1)))

      (while (and (>= have need))
        (when (< (- right left) min-len)
          (set! min-len (- right left))
          (set! min-start left))

        (let ([left-char (string-ref s left)])
          (update-count s-count left-char -1)
          (when (and (hash-ref t-count left-char #f)
                     (< (hash-ref s-count left-char 0) (hash-ref t-count left-char)))
            (set! have (- have 1)))
          (set! left (+ left 1)))))

  (if (= min-len +inf.0)
      ""
      (substring s min-start (+ min-start min-len))))