#lang racket

(define (shortest-supersequence-frequencies str1 str2)
  (define n (string-length str1))
  (define m (string-length str2))

  (define dp (make-vector (+ n 1)))
  (for ([i (in-range (+ n 1))])
    (vector-set! dp i (make-vector (+ m 1))))

  (for ([i (in-range (+ n 1))])
    (vector-set! (vector-ref dp i) 0 (cons i 1)))

  (for ([j (in-range (+ m 1))])
    (vector-set! (vector-ref dp 0) j (cons j 1)))

  (for ([i (in-range 1 (+ n 1))])
    (for ([j (in-range 1 (+ m 1))])
      (define char1 (string-ref str1 (- i 1)))
      (define char2 (string-ref str2 (- j 1)))

      (if (char=? char1 char2)
          (let* ([prev-pair (vector-ref (vector-ref dp (- i 1)) (- j 1))]
                 [prev-len (car prev-pair)]
                 [prev-count (cdr prev-pair)])
            (vector-set! (vector-ref dp i) j (cons (+ 1 prev-len) prev-count)))
          (let* ([left-pair (vector-ref (vector-ref dp (- i 1)) j)]
                 [left-len (car left-pair)]
                 [left-count (cdr left-pair)]

                 [up-pair (vector-ref (vector-ref dp i) (- j 1))]
                 [up-len (car up-pair)]
                 [up-count (cdr up-pair)])

            (cond
              [(< left-len up-len)
               (vector-set! (vector-ref dp i) j (cons (+ 1 left-len) left-count))]
              [(< up-len left-len)
               (vector-set! (vector-ref dp i) j (cons (+ 1 up-len) up-count))]
              [else
               (vector-set! (vector-ref dp i) j (cons (+ 1 left-len) (+ left-count up-count)))])))))

  (cdr (vector-ref (vector-ref dp n) m)))