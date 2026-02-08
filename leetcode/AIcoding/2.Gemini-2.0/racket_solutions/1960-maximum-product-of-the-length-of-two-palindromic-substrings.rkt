(define (max-product-palindrome-substrings s)
  (define n (string-length s))

  (define (manacher str)
    (define new-str (string-append "#" (string-join (map string (string->list str)) "#") "#"))
    (define new-n (string-length new-str))
    (define p (make-vector new-n 0))
    (define center 0)
    (define right 0)

    (for ([i (in-range new-n)])
      (if (< i right)
          (vector-set! p i (min (vector-ref p (+ (* 2 center) (- i))) (- right i))))

      (define left (- i (vector-ref p i) 1))
      (define right-bound (+ i (vector-ref p i) 1))

      (while (and (>= left 0) (< right-bound new-n) (char=? (string-ref new-str left) (string-ref new-str right-bound)))
        (vector-set! p i (+ (vector-ref p i) 1))
        (set! left (- left 1))
        (set! right-bound (+ right-bound 1)))

      (if (> right-bound right)
          (begin
            (set! center i)
            (set! right right-bound)))))

    (for/list ([i (in-range new-n)])
      (/ (vector-ref p i) 2)))

  (define p1 (manacher s))
  (define p2 (manacher (string-reverse s)))

  (define left-max (make-vector n 0))
  (define right-max (make-vector n 0))

  (for ([i (in-range n)])
    (define len (inexact->exact (floor (list-ref p1 i))))
    (define start (- i len))
    (define end (+ i len))

    (define length (+ (- end start) 1))

    (if (= i 0)
        (vector-set! left-max i length)
        (vector-set! left-max i (max length (vector-ref left-max (- i 1))))))

  (for ([i (in-range (- n 1) -1 -1)])
    (define len (inexact->exact (floor (list-ref p2 (- n 1 i)))))
    (define start (- i len))
    (define end (+ i len))
    (define length (+ (- end start) 1))

    (if (= i (- n 1))
        (vector-set! right-max i length)
        (vector-set! right-max i (max length (vector-ref right-max (+ i 1))))))

  (for/fold ([max-prod 0]) ([i (in-range (- n 1))])
    (max max-prod (* (vector-ref left-max i) (vector-ref right-max (+ i 1))))))