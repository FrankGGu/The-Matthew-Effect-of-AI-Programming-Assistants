#lang racket

(define (minimum-distance word)
  (define n (string-length word))
  (define memo (make-hash))

  (define (char->pos c)
    (define idx (- (char->integer (char-upcase c)) (char->integer #\A)))
    (cons (quotient idx 6) (remainder idx 6)))

  (define (distance a b)
    (if (or (not a) (not b))
        0
        (+ (abs (- (car a) (car b))) (abs (- (cdr a) (cdr b))))))

  (define (dp i finger1 finger2)
    (if (= i n)
        0
        (let ([key (list i finger1 finger2)])
          (if (hash-has-key? memo key)
              (hash-ref memo key)
              (let* ([current-char (string-ref word i)]
                     [current-pos (char->pos current-char)]
                     [move-finger1 (+ (dp (add1 i) current-pos finger2) (distance finger1 current-pos))]
                     [move-finger2 (+ (dp (add1 i) finger1 current-pos) (distance finger2 current-pos)])
                (hash-set! memo key (min move-finger1 move-finger2))
                (hash-ref memo key))))))

  (dp 0 #f #f))