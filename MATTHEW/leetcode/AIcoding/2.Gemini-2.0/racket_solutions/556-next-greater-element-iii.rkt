(define (next-greater-element-iii n)
  (define s (number->string n))
  (define len (string-length s))
  (define a (string->list s))

  (define (reverse-suffix lst start end)
    (let loop ([i start] [j end] [acc lst])
      (if (>= i j)
          acc
          (let ([temp (list-ref acc i)])
            (list->vector (cons (list-ref acc j) (vector->list (list->vector (cons temp (vector->list (list->vector acc))))) (vector->length (list->vector acc))))
            (loop (+ i 1) (- j 1) acc)))))

  (define (find-next-greater-digit lst index)
    (let loop ([i (- len 1)])
      (if (< i index)
          #f
          (if (> (string->number (list->string (list (list-ref lst i)))) (string->number (list->string (list (list-ref lst index)))))
              i
              (loop (- i 1))))))

  (let loop ([i (- len 2)])
    (if (< i 0)
        -1
        (let ([j (find-next-greater-digit a i)])
          (if j
              (let ([temp (list-ref a i)])
                (list->vector (cons (list-ref a j) (vector->list (list->vector (cons temp (vector->list (list->vector a))))) (vector->length (list->vector a))))
               (let ([reversed-a (reverse-suffix a (+ i 1) (- len 1))])

                   (let ([result (string->number (list->string reversed-a))])
                     (if (and (>= result 0) (<= result 2147483647))
                         result
                         -1))))
              (loop (- i 1)))))))