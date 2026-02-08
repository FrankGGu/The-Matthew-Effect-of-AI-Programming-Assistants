#lang racket

(define/contract (is-possible-to-cut-path grid)
  (-> (listof (listof exact-integer?)) boolean?)
  (define m (length grid))
  (define n (if (zero? m) 0 (length (car grid))))

  (define (dfs i j visited)
    (cond
      [(and (= i (sub1 m)) (= j (sub1 n))) #t]
      [(or (>= i m) (>= j n) (< i 0) (< j 0)) #f]
      [(= (list-ref (list-ref grid i) j) 0) #f]
      [(hash-ref visited (cons i j) #f) #f]
      [else
       (hash-set! visited (cons i j) #t)
       (or (dfs (add1 i) j visited)
           (dfs i (add1 j) visited))]))

  (define visited1 (make-hash))
  (if (not (dfs 0 0 visited1))
      #t
      (let ()
        (define visited2 (make-hash))
        (hash-set! visited2 (cons 0 0) #t)
        (not (or (dfs 1 0 visited2)
                 (dfs 0 1 visited2))))))