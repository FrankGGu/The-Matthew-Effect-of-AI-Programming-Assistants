(define (max-score s)
  (define (char->num c)
    (if (char=? c #\0) 0 1))
  (let loop ([left 0] [right (count (lambda (c) (char=? c #\1)) (string->list s))] [max-score 0] [i 0])
    (if (= i (sub1 (string-length s)))
        max-score
        (let* ([c (string-ref s i)]
               [new-left (+ left (if (char=? c #\0) 1 0))]
               [new-right (- right (if (char=? c #\1) 1 0))]
               [current-score (+ new-left new-right)])
          (loop new-left new-right (max max-score current-score) (add1 i))))))