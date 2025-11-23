(define (subarrayLCM nums k)
  (define (lcm a b)
    (if (= b 0)
        a
        (lcm b (remainder a b))))

  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (remainder a b))))

  (define (calculate-lcm lst)
    (if (null? lst)
        1
        (/ (* (car lst) (calculate-lcm (cdr lst)))
           (gcd (car lst) (calculate-lcm (cdr lst))))))

  (let loop ([i 0] [count 0])
    (if (= i (length nums))
        count
        (let loop2 ([j i] [current-lcm 1])
          (if (= j (length nums))
              (loop (+ i 1) count)
              (let ([new-lcm (/ (* (list-ref nums j) current-lcm)
                                (gcd (list-ref nums j) current-lcm))])
                (if (> new-lcm k)
                    (loop (+ i 1) count)
                    (if (= new-lcm k)
                        (loop2 (+ j 1) new-lcm)
                        (loop2 (+ j 1) new-lcm))
                    )
                (if (= new-lcm k)
                    (loop (+ i 1) (+ count 1))
                    (loop2 (+ j 1) new-lcm))
              )))))
  (let loop ([i 0] [count 0])
    (if (= i (length nums))
        count
        (let loop2 ([j i] [current-lcm 1])
          (if (= j (length nums))
              (loop (+ i 1) count)
              (let ([new-lcm (/ (* (list-ref nums j) current-lcm)
                                (gcd (list-ref nums j) current-lcm))])
                (if (> new-lcm k)
                    (loop (+ i 1) count)
                    (let ([new-count (if (= new-lcm k) (+ count 1) count)])
                      (loop2 (+ j 1) new-lcm new-count)))
              )))))
  (let loop ([i 0] [count 0])
    (if (= i (length nums))
        count
        (let loop2 ([j i] [current-lcm 1] [current-count count])
          (if (= j (length nums))
              (loop (+ i 1) current-count)
              (let ([new-lcm (/ (* (list-ref nums j) current-lcm)
                                (gcd (list-ref nums j) current-lcm))])
                (if (> new-lcm k)
                    (loop (+ i 1) current-count)
                    (let ([new-count (if (= new-lcm k) (+ current-count 1) current-count)])
                      (loop2 (+ j 1) new-lcm new-count)))
              )))))
  (let loop ([i 0] [count 0])
    (if (= i (length nums))
        count
        (let loop2 ([j i] [current-lcm 1])
          (if (= j (length nums))
              (loop (+ i 1) count)
              (let ([new-lcm (/ (* (list-ref nums j) current-lcm)
                                (gcd (list-ref nums j) current-lcm))])
                (cond
                  [(> new-lcm k) (loop (+ i 1) count)]
                  [(= new-lcm k) (loop (+ i 1) (+ count 1))]
                  [else (loop2 (+ j 1) new-lcm)]
                  )))))
  (let loop ([i 0] [count 0])
    (if (= i (length nums))
        count
        (let loop2 ([j i] [current-lcm 1])
          (if (= j (length nums))
              (loop (+ i 1) count)
              (let* ([num (list-ref nums j)]
                      [new-lcm (/ (* num current-lcm)
                                (gcd num current-lcm))])
                (cond
                  [(> new-lcm k) (loop (+ i 1) count)]
                  [(= new-lcm k) (loop (+ i 1) (+ count 1))]
                  [else (loop2 (+ j 1) new-lcm)]))))))
  (let loop ([i 0] [count 0])
    (if (= i (length nums))
        count
        (let loop2 ([j i] [current-lcm 1])
          (if (= j (length nums))
              (loop (+ i 1) count)
              (let* ([num (list-ref nums j)]
                     [new-lcm (if (= current-lcm 1) num
                                  (/ (* num current-lcm)
                                     (gcd num current-lcm)))])
                (cond
                  [(> new-lcm k) (loop (+ i 1) count)]
                  [(= new-lcm k) (loop (+ i 1) (+ count 1))]
                  [else (loop2 (+ j 1) new-lcm)]))))))

  (let loop ([i 0] [count 0])
    (if (= i (length nums))
        count
        (let loop2 ([j i] [current-lcm 1])
          (if (= j (length nums))
              (loop (+ i 1) count)
              (let* ([num (list-ref nums j)]
                     [new-lcm (if (= current-lcm 1) num
                                  (/ (* num current-lcm)
                                     (gcd num current-lcm)))])
                (cond
                  [(> new-lcm k)
                   (loop (+ i 1) count)]
                  [(= new-lcm k)
                   (loop (+ i 1) (+ count 1))]
                  [else
                   (loop2 (+ j 1) new-lcm)]))))))
  (let loop ([i 0] [count 0])
    (if (= i (length nums))
        count
        (let loop2 ([j i] [current-lcm 1])
          (if (= j (length nums))
              (loop (+ i 1) count)
              (let* ([num (list-ref nums j)]
                     [new-lcm (if (= current-lcm 1) num
                                  (let ([g (gcd num current-lcm)])
                                    (if (= g 0) 0 (/ (* num current-lcm) g))))])
                (cond
                  [(> new-lcm k)
                   (loop (+ i 1) count)]
                  [(= new-lcm k)
                   (loop (+ i 1) (+ count 1))]
                  [else
                   (loop2 (+ j 1) new-lcm)]))))))
  (let loop ([i 0] [count 0])
    (if (= i (length nums))
        count
        (let loop2 ([j i] [current-lcm 1])
          (if (= j (length nums))
              (loop (+ i 1) count)
              (let* ([num (list-ref nums j)]
                     [new-lcm (if (= current-lcm 1) num
                                  (let ([g (gcd num current-lcm)])
                                    (if (= g 0) 0 (/ (* num current-lcm) g))))])
                (cond
                  [(> new-lcm k) (loop (+ i 1) count)]
                  [(= new-lcm k) (loop (+ i 1) (+ count 1))]
                  [else (loop2 (+ j 1) new-lcm)]))))))

  (let loop ([i 0] [count 0])
    (if (= i (length nums))
        count
        (let loop2 ([j i] [current-lcm 1])
          (if (= j (length nums))
              (loop (+ i 1) count)
              (let* ([num (list-ref nums j)]
                     [new-lcm (if (= current-lcm 1) num
                                  (let ([g (gcd num current-lcm)])
                                    (if (= g 0) 0 (/ (* num current-lcm) g))))])
                (cond
                  [(> new-lcm k)