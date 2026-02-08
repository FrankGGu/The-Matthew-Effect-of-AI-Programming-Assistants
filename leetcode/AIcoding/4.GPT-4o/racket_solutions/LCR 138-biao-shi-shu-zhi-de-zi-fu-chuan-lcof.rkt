(define (is-valid-number s)
  (define (is-digit? c)
    (and (char? c) (char>=? c #\0) (char<=? c #\9)))

  (define (is-sign? c)
    (or (char=? c #\+) (char=? c #\-)))

  (define (is-exponent? c)
    (char=? c #\e))

  (define (is-valid-integer str)
    (if (or (string-empty? str) (and (= (string-length str) 1) (not (is-digit? (string-ref str 0)))))
        #f
        (let loop ((i 0))
          (if (= i (string-length str))
              #t
              (if (is-digit? (string-ref str i))
                  (loop (+ i 1))
                  (if (and (= i 0) (is-sign? (string-ref str i)))
                      (loop (+ i 1))
                      #f))))))

  (define (is-valid-decimal str)
    (let loop ((i 0) (dot-seen #f) (digit-seen #f))
      (if (= i (string-length str))
          (and digit-seen (or (not dot-seen) (and dot-seen (= i 1))))
          (let ((c (string-ref str i)))
            (cond
              ((is-digit? c) (loop (+ i 1) dot-seen #t))
              ((and (not dot-seen) (char=? c #\.)) (loop (+ i 1) #t digit-seen))
              ((and (is-sign? c) (= i 0)) (loop (+ i 1) dot-seen digit-seen))
              (else #f))))))

  (define (is-valid-exponential str)
    (let loop ((i 0) (has_digits #f))
      (if (= i (string-length str))
          has_digits
          (let ((c (string-ref str i)))
            (cond
              ((is-digit? c) (loop (+ i 1) #t))
              ((and (is-sign? c) (or (= i 0) (and (is-exponent? (string-ref str (- i 1))) (not has_digits)))))
               (loop (+ i 1) has_digits))
              ((is-exponent? c) (if has_digits (loop (+ i 1) #f) #f))
              (else #f))))))

  (define parts (string-split s #\space))
  (if (or (not (= (length parts) 1)) (string-empty? (first parts)))
      #f
      (let ((num-str (first parts)))
        (or (is-valid-integer num-str)
            (is-valid-decimal num-str)
            (let ((exp-index (string-index num-str (lambda (c) (is-exponent? c)))))
              (and exp-index (is-valid-decimal (substring num-str 0 exp-index))
                   (is-valid-exponential (substring num-str (+ exp-index 1))))))))))

(define (isNumber s)
  (is-valid-number (string-trim s)))