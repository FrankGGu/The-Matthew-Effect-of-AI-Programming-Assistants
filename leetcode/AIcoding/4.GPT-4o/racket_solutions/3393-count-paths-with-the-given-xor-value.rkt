(define (countPaths grid x)
  (define (dfs r c acc)
    (if (or (>= r (length grid)) (>= c (length (list-ref grid r))))
        0
        (let ((new-acc (bit-xor acc (list-ref (list-ref grid r) c))))
          (+ (if (= new-acc x) 1 0)
             (dfs (+ r 1) c new-acc)
             (dfs r (+ c 1) new-acc)))))
  (dfs 0 0 0))

(define (countPathsWithXor grid x)
  (countPaths grid x))