(define (three-sum-multiplicity arr target)
  (let* ((n (length arr))
         (mod (expt 10 9 7))
         (counts (make-hash)))
    (for ([x (in-list arr)])
      (hash-update! counts x add1 0))
    (let loop ([i 0] [result 0])
      (if (= i n)
          result
          (let* ((a (list-ref arr i))
                 (j (+ i 1)))
            (let inner-loop ([k j])
              (if (= k n)
                  (loop (+ i 1) result)
                  (let* ((b (list-ref arr k))
                         (c (- target a b)))
                    (if (hash-has-key? counts c)
                        (let* ((count-a (hash-ref counts a))
                               (count-b (hash-ref counts b))
                               (count-c (hash-ref counts c)))
                          (let ([add-to-result
                                 (cond
                                   [(and (= a b) (= b c))
                                    (/ (* count-a (- count-a 1) (- count-a 2)) 6)]
                                   [(and (= a b) (!= b c))
                                    (/ (* count-a (- count-a 1) count-c) 2)]
                                   [(and (= a c) (!= b c))
                                    (/ (* count-a (- count-a 1) count-b) 2)]
                                   [(and (= b c) (!= a c))
                                    (/ (* count-b (- count-b 1) count-a) 2)]
                                   [else
                                    (* count-a count-b count-c)])])
                            (inner-loop (+ k 1))
                            (loop (+ i 1) (modulo (+ result add-to-result) mod))))
                        (inner-loop (+ k 1))))))))))))