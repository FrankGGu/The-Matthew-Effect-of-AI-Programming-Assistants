#lang racket

(define (solve-equation equation)
  (define parts (string-split equation "="))
  (define left-side (car parts))
  (define right-side (cadr parts))

  (define (parse-side s)
    (let parse-loop ((idx 0)
                     (x-coeff 0)
                     (constant 0))
      (if (>= idx (string-length s))
          (list x-coeff constant)
          (let-values (((current-sign new-idx-after-sign)
                        (cond
                          ((and (< idx (string-length s)) (char=? (string-ref s idx) #\-)) (values -1 (+ idx 1)))
                          ((and (< idx (string-length s)) (char=? (string-ref s idx) #\+)) (values 1 (+ idx 1)))
                          (else (values 1 idx)))))
            (let-values (((num-val num-end-idx)
                          (let read-number ((j new-idx-after-sign) (num-str ""))
                            (if (and (< j (string-length s)) (char-numeric? (string-ref s j)))
                                (read-number (+ j 1) (string-append num-str (string (string-ref s j))))
                                (values (if (string=? num-str "") 1 (string->number num-str)) j)))))
              (if (and (< num-end-idx (string-length s)) (char=? (string-ref s num-end-idx) #\x))
                  (parse-loop (+ num-end-idx 1)
                              (+ x-coeff (* current-sign num-val))
                              constant)
                  (parse-loop num-end-idx
                              x-coeff
                              (+ constant (* current-sign num-val)))))))))

  (define left-parsed (parse-side left-side))
  (define lx (car left-parsed))
  (define lc (cadr left-parsed))

  (define right-parsed (parse-side right-side))
  (define rx (car right-parsed))
  (define rc (cadr right-parsed))

  (define final-x-coeff (- lx rx))
  (define final-constant (- rc lc))

  (cond
    ((and (= final-x-coeff 0) (= final-constant 0)) "Infinite solutions")
    ((= final-x-coeff 0) "No solution")
    (else (string-append "x=" (number->string (/ final-constant final-x-coeff))))))