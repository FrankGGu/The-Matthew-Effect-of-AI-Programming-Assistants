#lang racket

(define (ambiguous-coordinates s)
  (define (split s)
    (for/list ([i (in-range 1 (string-length s))])
      (cons (substring s 0 i) (substring s i))))

  (define (valid? s)
    (and (not (= (string-length s) 0))
         (or (= (string-length s) 1)
             (and (not (= (string-ref s 0) #\0))
                  (not (and (= (string-length s) 2)
                            (= (string-ref s 0) #\0)))))))

  (define (make-number s)
    (if (= (string-length s) 1)
        (list s)
        (if (valid? s)
            (list s (string-append s "." "0"))
            '())))

  (define (combine a b)
    (append
     (map (lambda (x) (string-append x " " b)) a)
     (map (lambda (x) (string-append a " " x)) b)
     (map (lambda (x) (string-append x " " b)) (make-number a))
     (map (lambda (x) (string-append a " " x)) (make-number b))
     (map (lambda (x) (string-append x " " b)) (make-number a))
     (map (lambda (x) (string-append a " " x)) (make-number b))))

  (define (process s)
    (for/fold ([res '()])
              ([pair (in-list (split s))])
      (let* ([a (car pair)]
             [b (cdr pair)]
             [a-valid (valid? a)]
             [b-valid (valid? b)])
        (if (and a-valid b-valid)
            (append res (combine a b))
            res))))

  (process (substring s 1 (sub1 (string-length s)))))