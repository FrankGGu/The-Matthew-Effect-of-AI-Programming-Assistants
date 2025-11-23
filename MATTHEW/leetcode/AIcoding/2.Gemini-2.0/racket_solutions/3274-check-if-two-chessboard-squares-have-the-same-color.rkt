(define (square-is-white? s)
  (let ((col (char->integer (string-ref s 0)))
        (row (string->number (substring s 1))))
    (even? (+ col row))))

(define (square-is-black? s)
  (not (square-is-white? s)))

(define (square-color s)
  (if (square-is-white? s)
      'white
      'black))

(define (square-color-equal s1 s2)
  (equal? (square-color s1) (square-color s2)))

(define (square-is-white-alt? s)
  (let ((col (char->integer (string-ref s 0)))
        (row (string->number (substring s 1))))
    (if (even? col)
        (even? row)
        (odd? row))))

(define (square-color-equal-alt s1 s2)
  (equal? (square-is-white-alt? s1) (square-is-white-alt? s2)))

(define (square-is-white-alt2? s)
  (let ((col (- (char->integer (string-ref s 0)) (char->integer #\a)))
        (row (- (string->number (substring s 1)) 1)))
    (even? (+ col row))))

(define (square-color-equal-alt2 s1 s2)
  (equal? (square-is-white-alt2? s1) (square-is-white-alt2? s2)))

(define (square-is-white-alt3? s)
  (let ((col (- (char->integer (string-ref s 0)) (char->integer #\a)))
        (row (- (string->number (substring s 1)) 1)))
    (not (remainder (+ col row) 2))))

(define (square-color-equal-alt3 s1 s2)
  (equal? (square-is-white-alt3? s1) (square-is-white-alt3? s2)))

(define (square-color-equal-alt4 s1 s2)
  (let ((col1 (- (char->integer (string-ref s1 0)) (char->integer #\a)))
        (row1 (- (string->number (substring s1 1)) 1))
        (col2 (- (char->integer (string-ref s2 0)) (char->integer #\a)))
        (row2 (- (string->number (substring s2 1)) 1)))
    (equal? (remainder (+ col1 row1) 2) (remainder (+ col2 row2) 2))))

(define (squareIsWhite s)
  (let ((col (- (char->integer (string-ref s 0)) (char->integer #\a)))
        (row (- (string->number (substring s 1)) 1)))
    (not (remainder (+ col row) 2))))

(define (square-color-equal-alt5 s1 s2)
  (equal? (squareIsWhite s1) (squareIsWhite s2)))

(define (squareIsWhite-direct s)
  (equal? (remainder (+ (char->integer (string-ref s 0)) (string->number (substring s 1))) 2) 0))

(define (squareAreSameColor s1 s2)
  (equal? (squareIsWhite s1) (squareIsWhite s2)))