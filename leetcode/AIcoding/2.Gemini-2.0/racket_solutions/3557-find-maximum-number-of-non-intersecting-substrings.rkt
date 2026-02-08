(define (max-num-non-overlapping-substrings s)
  (define n (string-length s))
  (define (find-min-max c)
    (let loop ([i 0] [min-idx #f] [max-idx #f])
      (cond
        [(>= i n) (list min-idx max-idx)]
        [(char=? c (string-ref s i))
         (if (and (not min-idx))
             (loop (+ i 1) i i)
             (loop (+ i 1) min-idx i))]
        [else (loop (+ i 1) min-idx max-idx)])))

  (define min-max-map
    (for/hash ([c (in-list (remove-duplicates (string->list s)))])
      (values c (find-min-max c))))

  (define (expand-interval min-idx max-idx)
    (let loop ([curr-min min-idx] [curr-max max-idx])
      (let ([expanded #f])
        (for ([i (in-range curr-min (+ curr-max 1))])
          (let ([c (string-ref s i)])
            (let ([mm (hash-ref min-max-map c)])
              (let ([curr-char-min (list-ref mm 0)]
                    [curr-char-max (list-ref mm 1)])
                (cond
                  [(and curr-char-min (< curr-char-min curr-min))
                   (set! curr-min curr-char-min)
                   (set! expanded #t)]
                  [(and curr-char-max (> curr-char-max curr-max))
                   (set! curr-max curr-char-max)
                   (set! expanded #t)])))))
        (if expanded
            (loop curr-min curr-max)
            (list curr-min curr-max)))))

  (define intervals
    (for/list ([c (in-list (remove-duplicates (string->list s)))])
      (let ([mm (hash-ref min-max-map c)])
        (let ([min-idx (list-ref mm 0)]
              [max-idx (list-ref mm 1)])
          (expand-interval min-idx max-idx)))))

  (define valid-intervals
    (filter
     (lambda (interval)
       (let ([min-idx (list-ref interval 0)]
             [max-idx (list-ref interval 1)])
         (let loop ([i min-idx])
           (cond
             [(>= i (+ max-idx 1)) #t]
             [else
              (let ([c (string-ref s i)])
                (let ([mm (hash-ref min-max-map c)])
                  (let ([char-min (list-ref mm 0)]
                        [char-max (list-ref mm 1)])
                    (if (or (< char-min min-idx) (> char-max max-idx))
                        #f
                        (loop (+ i 1)))))))]))))
     intervals))

  (define sorted-intervals
    (sort valid-intervals (lambda (a b) (< (list-ref a 1) (list-ref b 1)))))

  (define (find-non-overlapping intervals)
    (let loop ([remaining intervals] [last-end -1] [result '()])
      (cond
        [(null? remaining) (reverse result)]
        [else
         (let ([curr-interval (car remaining)]
               [curr-start (list-ref curr-interval 0)]
               [curr-end (list-ref curr-interval 1)])
           (if (>= curr-start last-end)
               (loop (cdr remaining) curr-end (cons (substring s curr-start (+ curr-end 1)) result))
               (loop (cdr remaining) last-end result)))])))

  (find-non-overlapping sorted-intervals))