(define (count-characters chars)
  (define (helper chars counts)
    (cond [(empty? chars) counts]
          [else
           (let* ([c (car chars)]
                  [current-count (hash-ref counts c 0)])
             (helper (cdr chars) (hash-set counts c (+ current-count 1))))]))
  (helper chars (make-hash)))

(define (can-form-word word char-counts)
  (define (helper word word-counts)
    (cond [(empty? word) #t]
          [else
           (let* ([c (car word)]
                  [word-count (hash-ref word-counts c 0)]
                  [char-count (hash-ref char-counts c 0)])
             (if (>= char-count word-count)
                 (helper (cdr word) word-counts)
                 #f))]))
  (helper word (count-characters word)))

(define (count-characters-leetcode words chars)
  (let* ([char-counts (count-characters chars)])
    (foldl (lambda (word acc)
             (if (can-form-word word char-counts)
                 (+ acc (string-length word))
                 acc))
           0
           words)))