(define (smallest-beautiful-string s k)
  (define (next-char c)
    (if (= c #\z) #\a
        (if (= c #\y) #\z
            (integer->char (+ 1 (char->integer c))))))

  (define (is-beautiful? str)
    (let loop ([i 1])
      (cond [(= i (string-length str)) #t]
            [(and (char=? (string-ref str i) (string-ref str (- i 1)))
                  (= (string-ref str i) (string-ref str (- i 2)))) #f]
            [else (loop (+ i 1))])))

  (define (generate str)
    (if (string=? str s)
      #f
      (let loop ([i (- (string-length str) 1)])
        (if (< i 0)
          #f
          (let* ([next (next-char (string-ref str i))]
                 [new-str (string-append (substring str 0 i) (string next))])
            (if (or (char=? next #\a) (> (string-length new-str) (string-length s)))
              (loop (- i 1))
              (let ([final-str (string-append new-str (make-string (- k (string-length new-str)) #\a))])
                (if (is-beautiful? final-str)
                  final-str
                  (loop (- i 1))))))))))

  (let ([result (generate s)])
    (if result result "")))