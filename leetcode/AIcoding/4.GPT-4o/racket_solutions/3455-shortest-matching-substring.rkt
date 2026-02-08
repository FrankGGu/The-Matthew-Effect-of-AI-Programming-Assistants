(define (min-window s t)
  (define (update-count count char delta)
    (if (char? char)
        (if (zero? delta)
            (hash-remove count char)
            (hash-set! count char (+ (hash-ref count char 0) delta)))
        count))

  (define (contains-all? count t-count)
    (for/fold ([result #t]) ([char (hash-keys t-count)])
      (if (>= (hash-ref count char 0) (hash-ref t-count char 0))
          result
          #f)))

  (define (find-substring s t)
    (define t-count (for/fold ([count (make-hash)])
                      ([char (string->list t)])
                      (update-count count char 1)))
    (define count (make-hash))
    (define left 0)
    (define min-length +inf.0)
    (define min-window '())

    (for ([right (in-range (string-length s))])
      (define char (string-ref s right))
      (set! count (update-count count char 1))

      (while (contains-all? count t-count)
        (define current-length (- (add1 right) left))
        (when (< current-length min-length)
          (set! min-length current-length)
          (set! min-window (substring s left (add1 right))))
        (set! count (update-count count (string-ref s left) -1))
        (set! left (add1 left))))

    (if (null? min-window) ""
        min-window))

(min-window "ADOBECODEBANC" "ABC")