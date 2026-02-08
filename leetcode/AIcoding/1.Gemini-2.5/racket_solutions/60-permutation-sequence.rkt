(define (get-permutation n k)
  (define factorials (make-vector (+ n 1)))
  (vector-set! factorials 0 1)
  (for ([i (in-range 1 (+ n 1))])
    (vector-set! factorials i (* i (vector-ref factorials (- i 1)))))

  (define digits (build-list n (lambda (i) (number->string (+ i 1)))))

  (define current-k (- k 1))

  (define (solve current-n k-val available-digits result-string)
    (if (= current-n 0)
        result-string
        (let* ([fact-val (vector-ref factorials (- current-n 1))]
               [index (quotient k-val fact-val)]
               [digit (list-ref available-digits index)]
               [new-k (modulo k-val fact-val)]
               [new-digits (append (take available-digits index) (drop available-digits (+ index 1)))]
               [new-result-string (string-append result-string digit)])
          (solve (- current-n 1) new-k new-digits new-result-string))))

  (solve n current-k digits ""))