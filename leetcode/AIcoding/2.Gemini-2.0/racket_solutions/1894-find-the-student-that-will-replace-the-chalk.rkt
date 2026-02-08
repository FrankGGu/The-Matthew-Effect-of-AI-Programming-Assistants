(define (chalk-replacer chalk k)
  (let loop ([i 0] [k k])
    (if (< k (list-ref chalk i))
        i
        (loop (+ i 1) (- k (list-ref chalk i))))
    )
  (let ([sum-chalk (apply + chalk)])
    (let loop ([i 0] [k (modulo k sum-chalk)])
      (if (< k (list-ref chalk i))
          i
          (loop (+ i 1) (- k (list-ref chalk i)))))))