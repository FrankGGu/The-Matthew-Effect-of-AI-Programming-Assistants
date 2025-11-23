(define (min-number-of-frogs croak-of-frogs)
  (let loop ([i 0] [c 0] [r 0] [o 0] [a 0] [k 0] [res 0] [current 0])
    (if (= i (string-length croak-of-frogs))
        (if (and (= c 0) (= r 0) (= o 0) (= a 0) (= k 0)) res -1)
        (let ([ch (string-ref croak-of-frogs i)])
          (cond
            [(char=? ch #\c) (loop (+ i 1) (+ c 1) r o a k (max res (+ current 1)) (+ current 1))]
            [(char=? ch #\r) (if (> c r) (loop (+ i 1) c (+ r 1) o a k res current) -1)]
            [(char=? ch #\o) (if (> r o) (loop (+ i 1) c r (+ o 1) a k res current) -1)]
            [(char=? ch #\a) (if (> o a) (loop (+ i 1) c r o (+ a 1) k res current) -1)]
            [(char=? ch #\k) (if (> a k) (loop (+ i 1) c r o a (+ k 1) (max res current) (- current 1)) -1)]
            [else -1])))))