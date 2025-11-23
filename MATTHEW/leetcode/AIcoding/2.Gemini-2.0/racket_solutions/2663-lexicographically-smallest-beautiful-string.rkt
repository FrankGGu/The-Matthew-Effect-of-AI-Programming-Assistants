(define (lexicographically-smallest-beautiful-string n k s)
  (define (is-beautiful? str)
    (let loop ([i 0])
      (cond
        [(= i (- (string-length str) 1)) #t]
        [(= i (- (string-length str) 2)) #t]
        [else (if (or (char=? (string-ref str i) (string-ref str (+ i 1)))
                       (char=? (string-ref str i) (string-ref str (+ i 2))))
                  #f
                  (loop (+ i 1)))])))

  (define (find-next-beautiful str idx)
    (cond
      [(= idx n)
       (if (is-beautiful? str)
           str
           #f)]
      [else
       (let loop ([char-code (char->integer #\a)])
         (cond
           [(> char-code (+ (char->integer #\a) k -1)) #f]
           [else
            (let ([new-str (string-copy str)])
              (string-set! new-str idx (integer->char char-code))
              (cond
                [(= idx 0)
                 (let ([result (find-next-beautiful new-str (+ idx 1))])
                   (if result
                       result
                       (loop (+ char-code 1))))]
                [(and (> idx 0)
                      (not (char=? (string-ref new-str (- idx 1)) (integer->char char-code)))
                      (or (< idx 2)
                          (not (char=? (string-ref new-str (- idx 2)) (integer->char char-code)))))
                 (let ([result (find-next-beautiful new-str (+ idx 1))])
                   (if result
                       result
                       (loop (+ char-code 1))))]
                [else
                 (loop (+ char-code 1))]))]))]))])

  (let ([result (find-next-beautiful s 0)])
    (if result
        result
        "")))