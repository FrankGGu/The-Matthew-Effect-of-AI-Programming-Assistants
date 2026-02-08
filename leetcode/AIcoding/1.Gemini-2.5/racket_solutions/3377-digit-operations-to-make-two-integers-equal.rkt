(define (solve num1 num2 k)
  (let* ((len1 (string-length num1))
         (len2 (string-length num2)))
    (if (not (= len1 len2))
        -1
        (let* ((g (gcd k 10)))
          (let loop ((i 0) (ops 0))
            (if (= i len1)
                ops
                (let* ((d1 (- (char->integer (string-ref num1 i)) (char->integer #\0)))
                       (d2 (- (char->integer (string-ref num2 i)) (char->integer #\0))))
                  (if (= d1 d2)
                      (loop (+ i 1) ops)
                      (let ((diff (modulo (- d2 d1) 10)))
                        (if (not (= (modulo diff g) 0))
                            -1
                            (loop (+ i 1) (+ ops 1))))))))))))