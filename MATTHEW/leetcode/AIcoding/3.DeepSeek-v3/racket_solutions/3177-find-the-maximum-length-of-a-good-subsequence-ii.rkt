(define/contract (maximum-length nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let ([n (length nums)])
    (let loop ([i 0] [dp (make-hash)] [max-len 0])
      (if (>= i n)
          max-len
          (let* ([num (list-ref nums i)]
                 [new-dp (make-hash)]
                 [current-max 1])
            (hash-for-each dp (lambda (key val)
                                (let ([diff (- num key)])
                                  (when (<= diff k)
                                    (let ([new-val (+ val 1)])
                                      (hash-set! new-dp key new-val)
                                      (set! current-max (max current-max new-val)))))))
            (hash-set! new-dp num (max current-max (hash-ref dp num 0)))
            (loop (+ i 1) new-dp (max max-len current-max (hash-ref new-dp num 0))))))))