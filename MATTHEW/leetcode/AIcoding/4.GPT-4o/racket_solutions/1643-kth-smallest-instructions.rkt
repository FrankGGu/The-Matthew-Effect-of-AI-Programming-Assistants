(define (kthSmallestInstructions n k)
  (define (factorial x)
    (if (= x 0) 1 (* x (factorial (- x 1)))))

  (define (combinations n k)
    (/ (factorial n) (* (factorial k) (factorial (- n k)))))

  (define (find-instructions n k)
    (define (helper x y k path)
      (if (or (= x 0) (= y 0))
          (string-append path (make-string x #\R) (make-string y #\D))
          (let loop ((i 0) (c 0))
            (if (>= c k)
                path
                (let ((c2 (combinations (- x 1) y)))
                  (if (< c2 (+ c k))
                      (loop (+ i 1) (+ c c2))
                      (helper (- x 1) y k (string-append path "R")))))))
    (helper n n k ""))

  (find-instructions n k))