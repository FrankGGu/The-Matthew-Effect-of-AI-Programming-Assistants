(define (max-word-unique-length-product words)
  (define (get-mask word)
    (let loop ([i 0] [mask 0])
      (if (= i (string-length word))
          mask
          (loop (+ i 1) (bitwise-ior mask (arithmetic-shift 1 (- (char->integer (string-ref word i)) 97)))))))

  (define masks (map get-mask words))

  (define (product a b)
    (* (string-length (list-ref words a)) (string-length (list-ref words b))))

  (define (valid? a b)
    (= (bitwise-and (list-ref masks a) (list-ref masks b)) 0))

  (let loop ([i 0] [max-prod 0])
    (if (= i (length words))
        max-prod
        (let loop2 ([j (+ i 1)] [current-max max-prod])
          (if (= j (length words))
              (loop (+ i 1) current-max)
              (if (valid? i j)
                  (loop2 (+ j 1) (max current-max (product i j)))
                  (loop2 (+ j 1) current-max)))))))