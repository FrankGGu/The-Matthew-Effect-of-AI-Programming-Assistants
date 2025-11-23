#lang racket

(define (is-prime? n)
  (cond
    ((< n 2) #f)
    ((= n 2) #t)
    ((even? n) #f)
    (else
     (let loop ((i 3))
       (cond
         ((> (* i i) n) #t)
         ((zero? (remainder n i)) #f)
         (else (loop (+ i 2))))))))

(define (most-frequent-prime mat)
  (define m (vector-length mat))
  (define n (vector-length (vector-ref mat 0)))

  (define counts (make-hash))

  (define (add-prime-to-counts p)
    (when (is-prime? p)
      (hash-update! counts p add1 0)))

  (define (in-bounds? r c)
    (and (>= r 0) (< r m) (>= c 0) (< c n)))

  (define directions
    '((-1 -1) (-1 0) (-1 1)
      (0 -1)          (0 1)
      (1 -1)  (1 0)  (1 1)))

  (for* ([r (in-range m)]
         [c (in-range n)])
    (for ([dir directions])
      (define dr (first dir))
      (define dc (second dir))

      (let loop ((curr-r r)
                 (curr-c c)
                 (current-num 0))
        (when (in-bounds? curr-r curr-c)
          (define digit (vector-ref (vector-ref mat curr-r) curr-c))
          (define new-num (+ (* current-num 10) digit))

          (add-prime-to-counts new-num)

          (loop (+ curr-r dr) (+ curr-c dc) new-num)))))

  (define max-freq -1)
  (define result -1)

  (hash-for-each
   counts
   (lambda (p freq)
     (cond
       ((> freq max-freq)
        (set! max-freq freq)
        (set! result p))
       ((and (= freq max-freq) (> p result))
        (set! result p)))))

  result)