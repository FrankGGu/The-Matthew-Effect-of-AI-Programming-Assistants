(define (findMaxLength nums)
  (let* ([n (length nums)]
         [count 0]
         [max-length 0]
         [map (make-hash)]
         )
    (hash-set! map 0 -1)
    (for/list ([i (in-range n)])
      (if (= (list-ref nums i) 0)
          (set! count (- count 1))
          (set! count (+ count 1)))
      (cond
        [(hash-has-key? map count)
         (set! max-length (max max-length (- i (hash-ref map count))))]
        [else
         (hash-set! map count i)]))
    max-length))