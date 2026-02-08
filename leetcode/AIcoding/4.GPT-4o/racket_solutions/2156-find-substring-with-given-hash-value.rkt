(define (substring-hash s hashValue length)
  (define base 31)
  (define mod (expt 10 9))

  (define (hash str)
    (foldl (lambda (c acc) 
              (mod (+ (* acc base) (char->integer c))) 
              ) 
            0 
            str))

  (define (rolling-hash str)
    (define n (string-length str))
    (define h (hash (substring s 0 length)))
    (define hashes (list h))

    (for ([i (in-range 1 (+ n 1 (- length)))])
      (if (< i n)
          (set! h (mod (+ (* h base) (char->integer (string-ref s i))) 
                        (- (* (expt base length) (char->integer (string-ref s (- i length)))) mod)))
          (set! h (mod (- h (* (expt base length) (char->integer (string-ref s (- i length))))) mod)))
      (set! hashes (append hashes (list h))))
    hashes)

  (define hashes (rolling-hash s))
  (define n (length hashes))

  (for ([i (in-range n)])
    (if (= (list-ref hashes i) hashValue)
        (return (substring s i (+ i length)))))

  "")

(substring-hash "abc" 96 2)