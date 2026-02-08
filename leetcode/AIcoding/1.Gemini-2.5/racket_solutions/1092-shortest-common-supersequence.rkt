#lang racket

(define (shortest-common-supersequence str1 str2)
  (define m (string-length str1))
  (define n (string-length str2))

  (define dp (make-vector (+ m 1)))
  (for ([i (in-range (+ m 1))])
    (vector-set! dp i (make-vector (+ n 1) 0)))

  (for ([i (in-range 1 (+ m 1))])
    (for ([j (in-range 1 (+ n 1))])
      (if (char=? (string-ref str1 (sub1 i)) (string-ref str2 (sub1 j)))
          (vector-set! (vector-ref dp i) j (+ 1 (vector-ref (vector-ref dp (sub1 i)) (sub1 j))))
          (vector-set! (vector-ref dp i) j (max (vector-ref (vector-ref dp (sub1 i)) j)
                                                 (vector-ref (vector-ref dp i) (sub1 j)))))))

  (define i m)
  (define j n)
  (define result '())

  (let loop ()
    (when (and (> i 0) (> j 0))
      (if (char=? (string-ref str1 (sub1 i)) (string-ref str2 (sub1 j)))
          (begin
            (set! result (cons (string-ref str1 (sub1 i)) result))
            (set! i (sub1 i))
            (set! j (sub1 j))
            (loop))
          (if (> (vector-ref (vector-ref dp (sub1 i)) j) (vector-ref (vector-ref dp i) (sub1 j)))
              (begin
                (set! result (cons (string-ref str1 (sub1 i)) result))
                (set! i (sub1 i))
                (loop))
              (begin
                (set! result (cons (string-ref str2 (sub1 j)) result))
                (set! j (sub1 j))
                (loop))))))

  (let loop-i ()
    (when (> i 0)
      (set! result (cons (string-ref str1 (sub1 i)) result))
      (set! i (sub1 i))
      (loop-i)))

  (let loop-j ()
    (when (> j 0)
      (set! result (cons (string-ref str2 (sub1 j)) result))
      (set! j (sub1 j))
      (loop-j)))

  (list->string result))