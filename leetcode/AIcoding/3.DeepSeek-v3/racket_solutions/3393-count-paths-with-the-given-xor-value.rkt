#lang racket

(define (count-paths root target)
  (let ([count 0]
        [prefix-xor (make-hash)])
    (hash-set! prefix-xor 0 1)
    (define (dfs node current-xor)
      (when node
        (let* ([val (vector-ref node 0)]
               [new-xor (bitwise-xor current-xor val)])
          (set! count (+ count (hash-ref prefix-xor (bitwise-xor new-xor target) 0)))
          (hash-update! prefix-xor new-xor add1 0)
          (dfs (vector-ref node 1) new-xor)
          (dfs (vector-ref node 2) new-xor)
          (hash-update! prefix-xor new-xor sub1 0))))
      count)
    (dfs root 0)))