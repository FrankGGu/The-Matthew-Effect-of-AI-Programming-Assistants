(define (magical-string n)
  (define (generate-string)
    (let loop ([s '(1 2 2)] [ones 1] [twos 2])
      (if (> (length s) n)
          (take s n)
          (if (= (list-ref s (length s) -1) 1)
              (loop (append s (list ones)) ones (+ twos 1))
              (loop (append s (list ones ones)) ones (+ twos 2))))))

  (define str (generate-string))

  (length (filter (lambda (x) (= x 1)) str)))