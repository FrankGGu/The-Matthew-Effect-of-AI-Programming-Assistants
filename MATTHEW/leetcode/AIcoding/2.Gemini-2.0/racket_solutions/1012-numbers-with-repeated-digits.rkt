(define (num-dup-digits n)
  (define digits (list->vector (map string->number (string->list (number->string n)))))
  (define len (vector-length digits))

  (define (count-no-dup k)
    (define (fact n)
      (if (= n 0)
          1
          (* n (fact (- n 1)))))
    (define (perm n k)
      (/ (fact n) (fact (- n k))))
    (if (< k 1)
        1
        (* 9 (perm 9 (- k 1)))))

  (define (solve idx seen)
    (if (= idx len)
        1
        (let loop ((i 0) (res 0))
          (if (= i (vector-ref digits idx))
              (if (member (vector-ref digits idx) seen)
                  res
                  (+ res (solve (+ idx 1) (cons (vector-ref digits idx) seen))))
              (if (< i (vector-ref digits idx))
                  (if (member i seen)
                      (loop (+ i 1) res)
                      (loop (+ i 1) (+ res (* (if (= idx 0) 9 10)
                                                (apply * (map (lambda (x) (- 10 x)) (range 0 (length seen))))
                                                (if (= (- len idx 1) 0) 1 (perm (- 10 (length seen)) (- len idx 1)))))))
                  res)))))

  (- n (let loop ((i 1) (res 0))
         (if (= i len)
             (+ res (solve 0 '()))
             (+ res (if (= i 1) 0 (count-no-dup i)) (loop (+ i 1) res))))))