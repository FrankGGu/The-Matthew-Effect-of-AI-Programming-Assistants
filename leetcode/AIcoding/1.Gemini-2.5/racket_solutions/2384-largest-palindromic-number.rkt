#lang racket

(define (largest-palindromic num)
  (define counts (make-vector 10 0))

  (for ([char (string->list num)])
    (define digit (- (char->integer char) (char->integer #\0)))
    (vector-set! counts digit (+ (vector-ref counts digit) 1)))

  (define left-half (string-builder))
  (define middle-char #f)

  (for ([digit (range 9 -1 -1)])
    (let ([count (vector-ref counts digit)])
      (let ([pairs (quotient count 2)])
        (when (> pairs 0)
          (string-builder-add-string! left-half (make-string pairs (integer->char (+ (char->integer #\0) digit))))))))

  (for ([digit (range 9 -1 -1)])
    (let ([count (vector-ref counts digit)])
      (when (and (odd? count) (not middle-char))
        (set! middle-char (integer->char (+ (char->integer #\0) digit))))))

  (define left-str (string-builder-get-string left-half))

  (cond
    [(and (string=? left-str "") (not middle-char))
     "0"]
    [(and (not (string=? left-str "")) (char=? (string-ref left-str 0) #\0))
     "0"]
    [else
     (define result-str left-str)
     (when middle-char
       (set! result-str (string-append result-str (string middle-char))))
     (set! result-str (string-append result-str (string-reverse left-str)))
     result-str]))