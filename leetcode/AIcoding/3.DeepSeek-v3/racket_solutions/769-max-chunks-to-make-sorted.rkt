(define/contract (max-chunks-to-sorted arr)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([arr arr] [max-so-far -inf.0] [count 0])
    (if (null? arr)
        count
        (let* ([current (car arr)]
               [new-max (max max-so-far current)]
               [new-count (if (= new-max count) (add1 count) count)])
          (loop (cdr arr) new-max new-count)))))