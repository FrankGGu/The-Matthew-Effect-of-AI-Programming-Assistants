#lang racket

(define (split-word s)
  (define len (string-length s))
  (define (helper i j res)
    (if (> i j)
        res
        (let ([c (string-ref s i)])
          (if (char-numeric? c)
              (helper (+ i 1) j (cons c res))
              (helper (+ i 1) j res)))))
  (list->string (reverse (helper 0 (- len 1) '()))))

(define (count-squares s)
  (define (count str)
    (define len (string-length str))
    (for/sum ([i (in-range len)])
      (if (and (>= i 1) (char=? (string-ref str i) (string-ref str (- i 1))))
          1
          0)))
  (count s))

(define (can-split s)
  (define len (string-length s))
  (define (check i j)
    (if (> i j)
        #t
        (let ([left (substring s 0 i)]
              [right (substring s j len)])
          (and (count-squares left) (count-squares right)))))
  (for/first ([i (in-range 1 len)])
    (when (check i (+ i 1))
      #t))
  #f)

(define (split-string s)
  (define len (string-length s))
  (define (helper i j res)
    (if (> i j)
        res
        (let ([c (string-ref s i)])
          (if (char-numeric? c)
              (helper (+ i 1) j (cons c res))
              (helper (+ i 1) j res)))))
  (list->string (reverse (helper 0 (- len 1) '()))))

(define (main)
  (define s (read-line))
  (if (can-split s)
      (display "true")
      (display "false")))

(main)