(define/contract (minimum-index nums)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([n (length nums)]
         [left (make-hash)]
         [right (make-hash)]
         [dominant -1]
         [count 0])
    (for ([num nums])
      (hash-update! right num add1 0))
    (for ([(num cnt) (in-hash right)]
      (when (> cnt (/ n 2))
        (set! dominant num)
        (set! count cnt)))
    (if (= dominant -1)
        -1
        (let loop ([i 0]
                   [left-count 0]
                   [right-count count]
                   [result -1])
          (if (>= i (sub1 n))
              result
              (let* ([num (list-ref nums i)]
                     [new-left-count (if (= num dominant) (add1 left-count) left-count)]
                     [new-right-count (if (= num dominant) (sub1 right-count) right-count)]
                     [valid? (and (> new-left-count (/ (add1 i) 2))
                                  (> new-right-count (/ (- n (add1 i)) 2)))])
                (if valid?
                    (if (or (= result -1) (< i result))
                        (loop (add1 i) new-left-count new-right-count i)
                        (loop (add1 i) new-left-count new-right-count result))
                    (loop (add1 i) new-left-count new-right-count result))))))))