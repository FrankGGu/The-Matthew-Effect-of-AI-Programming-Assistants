(define (remove-comments source)
  (let loop ([lines source] [res '()] [in-block? #f])
    (cond
      [(null? lines) (reverse res)]
      [else
       (let* ([line (car lines)]
              [n (string-length line)]
              [new-line (string #\space 0)])
         (let loop2 ([i 0] [new-line-acc ""] [in-string? #f])
           (cond
             [(= i n)
              (cond
                [in-string? (loop (cdr lines) (cons new-line-acc res) in-string?)]
                [in-block? (loop (cdr lines) res in-block?)]
                [else (if (string=? new-line-acc "")
                          (loop (cdr lines) res in-block?)
                          (loop (cdr lines) (cons new-line-acc res) in-block?))])]
             [else
              (let ([c (string-ref line i)])
                (cond
                  [in-block?
                   (if (and (>= (- n i) 2) (char=? c #\*) (char=? (string-ref line (+ i 1)) #\/))
                       (loop2 (+ i 2) new-line-acc #f)
                       (loop2 (+ i 1) new-line-acc in-block?))]
                  [in-string?
                   (if (char=? c #\\)
                       (loop2 (+ i 2) (string-append new-line-acc (substring line i (+ i 2))) in-string?)
                       (if (char=? c #\")
                           (loop2 (+ i 1) (string-append new-line-acc (string c)) #f)
                           (loop2 (+ i 1) (string-append new-line-acc (string c)) in-string?)))]
                  [else
                   (cond
                     [(and (>= (- n i) 2) (char=? c #\/) (char=? (string-ref line (+ i 1)) #\*))
                      (loop2 (+ i 2) new-line-acc #t)]
                     [(and (>= (- n i) 2) (char=? c #\/) (char=? (string-ref line (+ i 1)) #\/))
                      (loop2 n new-line-acc #f)]
                     [(char=? c #\")
                      (loop2 (+ i 1) (string-append new-line-acc (string c)) #t)]
                     [else
                      (loop2 (+ i 1) (string-append new-line-acc (string c)) #f)]))]))]))]))))