#lang racket

(define (maximum-good-people-based-on-statements statements)
  (let* ((n (length statements)))

    (define (popcount num)
      (let loop ((k num) (count 0))
        (if (= k 0)
            count
            (loop (bitwise-and k (sub1 k)) (add1 count)))))

    (define (is-consistent? mask)
      (for/and ((i (in-range n)))
        (let ((i-is-good? (= 1 (bitwise-and (arithmetic-shift mask (- i)) 1))))
          (if i-is-good?
              (for/and ((j (in-range n)))
                (let ((statement (list-ref (list-ref statements i) j)))
                  (case statement
                    ((2) #t)
                    ((0)
                     (= 0 (bitwise-and (arithmetic-shift mask (- j)) 1)))
                    ((1)
                     (= 1 (bitwise-and (arithmetic-shift mask (- j)) 1))))))
              #t))))

    (for/max ((mask (in-range (expt 2 n))))
      (if (is-consistent? mask)
          (popcount mask)
          0))))