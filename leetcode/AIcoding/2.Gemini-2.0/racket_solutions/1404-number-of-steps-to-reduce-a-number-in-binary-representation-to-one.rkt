(define (numSteps s)
  (let loop ([str s] [steps 0])
    (cond
      [(equal? str "1") steps]
      [(equal? (last str) #\0) (loop (substring str 0 (- (string-length str) 1)) (+ steps 1))]
      [else (let* ([carry 1] [new-str ""])
              (for/fold ([new-str ""] [carry carry]) ([i (reverse (string->list str))])
                (let ([digit (char->number i)] [sum (+ digit carry)])
                  (values (string-append new-str (number->string (modulo sum 2))) (floor (/ sum 2)))))
              (if (> carry 0) (loop (string-append "1" (reverse new-str)) (+ steps 1))
                  (loop (reverse new-str) (+ steps 1))))])))

(define (last s)
  (string-ref s (- (string-length s) 1)))

(define (char->number c)
  (- (char->integer c) (char->integer #\0)))