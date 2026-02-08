(define (split-into-fibonacci s)
  (define n (string-length s))
  (define result '())

  (define (backtrack index seq)
    (cond
      [(= index n)
       (and (>= (length seq) 3) (set! result seq) #t)]
      [else
       (for/or ([i (in-range index n)])
         (let* ([len (+ 1 (- i index))]
                [num-str (substring s index (+ index len))]
                [num (string->number num-str)])
           (cond
             [(or (and (= len 1) (= (string-ref num-str 0) #\0))
                  (and (> len 1) (= (string-ref num-str 0) #\0)))
              #f]
             [(or (not num) (> num (expt 2 31)))
              #f]
             [else
              (let ([slen (length seq)])
                (cond
                  [(< slen 2)
                   (backtrack (+ index len) (append seq (list num)))]
                  [(= num (+ (list-ref seq (- slen 1)) (list-ref seq (- slen 2))))
                   (backtrack (+ index len) (append seq (list num)))]
                  [else
                   #f]))]))])]))

  (if (backtrack 0 '())
      result
      '()))