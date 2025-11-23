#lang racket

(define (remove-comments source)
  (define (helper lines result in-comment)
    (cond [(null? lines) (reverse result)]
          [else
           (define line (car lines))
           (if in-comment
               (let ([end (string-index line #\*)])
                 (if end
                     (helper (cdr lines) result #f)
                     (helper (cdr lines) result #t)))
               (let ([start (string-index line #\/)])
                 (if start
                     (let ([next (string-index (substring line (add1 start)) #\/)])
                       (if next
                           (helper (cdr lines) (cons (substring line 0 start) result) #f)
                           (let ([end (string-index (substring line (add1 start)) #\*)])
                             (if end
                                 (helper (cdr lines) (cons (substring line 0 start) result) #t)
                                 (helper (cdr lines) (cons line result) #f))))
                     (helper (cdr lines) (cons line result) #f)))]))
  (reverse (helper source '() #f)))

(define (string-index s c)
  (let loop ([i 0])
    (if (= i (string-length s))
        #f
        (if (char=? (string-ref s i) c)
            i
            (loop (+ i 1)))))