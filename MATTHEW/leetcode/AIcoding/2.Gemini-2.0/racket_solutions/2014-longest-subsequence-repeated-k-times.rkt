(define (longest-subsequence-repeated-k-times s k)
  (define (is-subsequence? sub str)
    (cond
      [(empty? sub) #t]
      [(empty? str) #f]
      [else
       (if (equal? (first sub) (first str))
           (is-subsequence? (rest sub) (rest str))
           (is-subsequence? sub (rest str)))]))

  (define (count-subsequence sub str)
    (if (empty? str)
        0
        (let ((count 0))
          (for ([i (in-range 0 (string-length str))])
            (if (is-subsequence? sub (substring str i (string-length str)))
                (set! count (+ count 1))))
          count)))

  (define (find-longest s k)
    (let* ((n (string-length s))
           (chars (remove-duplicates (string->list s)))
           (longest ""))
      (let loop ([current ""])
        (cond
          [(> (string-length current) n)
           #f]
          [else
           (for ([c (in-list chars)])
             (let ((next-current (string-append current (string c))))
               (if (>= (count-subsequence next-current s) k)
                   (begin
                     (set! longest next-current)
                     (loop next-current)))))
           longest])))

  (let loop ([current ""] [longest ""])
    (let* ((n (string-length s))
           (chars (remove-duplicates (string->list s))))
      (for ([c (in-list chars)])
        (let ((next-current (string-append current (string c))))
          (if (>= (count-subsequence next-current s) k)
              (begin
                (if (> (string-length next-current) (string-length longest))
                    (set! longest next-current))
                (set! longest (loop next-current longest))))))
      longest))
  (let* ((n (string-length s))
         (chars (remove-duplicates (string->list s)))
         (possible-chars (filter (lambda (c) (>= (count-occurrences s c) k)) chars))
         (longest ""))
    (let loop ([current ""])
      (cond
        [(> (string-length current) (/ n k))
         #f]
        [else
         (for ([c (in-list possible-chars)])
           (let ((next-current (string-append current (string c))))
             (if (>= (count-subsequence next-current s) k)
                 (begin
                   (if (> (string-length next-current) (string-length longest))
                       (set! longest next-current))
                   (loop next-current))))
           longest)]))
    (if (string=? longest "")
        ""
        (let loop ([current longest])
          (let* ((chars (remove-duplicates (string->list s)))
                 (longer-found? #f))
            (for ([c (in-list chars)])
              (let ((next-current (string-append current (string c))))
                (if (>= (count-subsequence next-current s) k)
                    (begin
                      (set! longer-found? #t)
                      (set! current next-current)))))
            (if longer-found?
                (loop current)
                current)))))
  )

(define (count-occurrences str char)
  (let loop ([str-list (string->list str)] [count 0])
    (cond
      [(empty? str-list) count]
      [(equal? (first str-list) char) (loop (rest str-list) (+ count 1))]
      [else (loop (rest str-list) count)])))