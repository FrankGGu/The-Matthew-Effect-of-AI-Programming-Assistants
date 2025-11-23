#lang racket

(define (buddy-strings s t)
  (if (not (= (string-length s) (string-length t)))
      #f
      (let ([s-list (string->list s)]
            [t-list (string->list t)])
        (if (equal? s-list t-list)
            (let loop ([i 0] [seen '()])
              (if (= i (length s-list))
                  #f
                  (let ([c (list-ref s-list i)])
                    (if (member c seen)
                        #t
                        (loop (+ i 1) (cons c seen))))))
            (let ([diffs '()])
              (for ([i (in-range (string-length s))])
                (when (not (= (char->integer (list-ref s-list i))
                              (char->integer (list-ref t-list i))))
                  (set! diffs (cons i diffs))))
              (and (= (length diffs) 2)
                   (= (char->integer (list-ref s-list (car diffs)))
                      (char->integer (list-ref t-list (cadr diffs))))
                   (= (char->integer (list-ref s-list (cadr diffs)))
                      (char->integer (list-ref t-list (car diffs)))))))))