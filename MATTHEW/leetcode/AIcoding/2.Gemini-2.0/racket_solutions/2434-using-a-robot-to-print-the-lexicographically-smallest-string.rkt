(define (robot-print s)
  (define n (string-length s))
  (define (solve s buffer result)
    (cond
      [(and (empty? s) (empty? buffer)) result]
      [(empty? s) (string-append result (list->string buffer))]
      [(empty? buffer)
       (solve (substring s 1 n) (list (string-ref s 0)) result)]
      [else
       (let ([min-char (string-ref s 0)])
         (for ([i (in-range 1 n)])
           (set! min-char (min min-char (string-ref s i))))
         (define (find-next-min s min-char)
           (let loop ([i 0])
             (cond
               [(>= i (string-length s)) #f]
               [(= (string-ref s i) min-char) i]
               [else (loop (+ i 1))])))
         (let loop ([curr-s s] [curr-buffer buffer] [curr-result result])
           (if (empty? curr-s)
               (string-append curr-result (list->string (reverse curr-buffer)))
               (if (< (string-ref curr-s 0) (car curr-buffer))
                   (solve (substring curr-s 1 n) (cons (string-ref curr-s 0) curr-buffer) curr-result)
                   (if (<= (car curr-buffer) min-char)
                       (loop curr-s (cdr curr-buffer) (string-append curr-result (string (car curr-buffer))))
                       (let ([idx (find-next-min curr-s min-char)])
                         (if idx
                             (solve (substring curr-s (+ idx 1) n) (append (reverse (take (string->list curr-s) idx)) curr-buffer) curr-result)
                             (string-append curr-result (list->string (append (reverse curr-buffer) (string->list curr-s))))))))))))]))
  (solve s '() ""))