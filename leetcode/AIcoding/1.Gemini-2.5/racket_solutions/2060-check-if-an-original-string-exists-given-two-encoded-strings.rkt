#lang racket

(define (check-if-original-string-exists s1 s2)
  (define n1 (string-length s1))
  (define n2 (string-length s2))

  (define memo (make-hash))

  (define (char-at s idx)
    (if (and (>= idx 0) (< idx (string-length s)))
        (string-ref s idx)
        #f))

  (define (char-digit? c)
    (and c (char-numeric? c)))

  (define (parse-num s idx)
    (let loop ((k idx) (num 0) (len 0))
      (let ((c (char-at s k)))
        (if (char-digit? c)
            (loop (+ k 1) (+ (* num 10) (- (char->integer c) (char->integer #\0))) (+ len 1))
            (list num len)))))

  (define (solve i j diff)
    (let ((diff-offset (+ diff 40)))
      (let ((key (list i j diff-offset)))
        (cond
          ((hash-has-key? memo key) (hash-ref memo key))
          (else
           (let ((result
                  (cond
                    ((and (= i n1) (= j n2)) (= diff 0))

                    ((> diff 0)
                     (if (= j n2)
                         #f
                         (let ((c2 (char-at s2 j)))
                           (if (char-digit? c2)
                               (let-values (((num2 len2) (apply values (parse-num s2 j))))
                                 (solve i (+ j len2) (- diff num2)))
                               (solve i (+ j 1) (- diff 1))))))

                    ((< diff 0)
                     (if (= i n1)
                         #f
                         (let ((c1 (char-at s1 i)))
                           (if (char-digit? c1)
                               (let-values (((num1 len1) (apply values (parse-num s1 i))))
                                 (solve (+ i len1) j (+ diff num1)))
                               (solve (+ i 1) j (+ diff 1))))))

                    (else
                     (let ((c1 (char-at s1 i))
                           (c2 (char-at s2 j)))
                       (cond
                         ((and (= i n1) (< j n2)) #f)
                         ((and (< i n1) (= j n2)) #f)

                         (else
                          (cond
                            ((and (not (char-digit? c1)) (not (char-digit? c2)))
                             (if (char=? c1 c2)
                                 (solve (+ i 1) (+ j 1) 0)
                                 #f))
                            ((and (char-digit? c1) (not (char-digit? c2)))
                             (let-values (((num1 len1) (apply values (parse-num s1 i))))
                               (solve (+ i len1) j num1)))
                            ((and (not (char-digit? c1)) (char-digit? c2)))
                             (let-values (((num2 len2) (apply values (parse-num s2 j))))
                               (solve i (+ j len2) (- 0 num2))))
                            (else
                             (let-values (((num1 len1) (apply values (parse-num s1 i))))
                               (let-values (((num2 len2) (apply values (parse-num s2 j))))
                                 (or (solve (+ i len1) j num1)
                                     (solve i (+ j len2) (- 0 num2))))))))))))
           (hash-set! memo key result)
           result))))))

  (solve 0 0 0))