(define (can-jump arr start)
  (define n (length arr))
  (define visited (make-vector n #f))

  (define (dfs idx)
    (if (or (>= idx n) (vector-ref visited idx))
        #f
        (begin
          (vector-set! visited idx #t)
          (if (= (vector-ref arr idx) 0)
              #t
              (let ((jump (vector-ref arr idx)))
                (or (dfs (+ idx jump))
                    (dfs (- idx jump))))))))

  (dfs start))

(define (canJump arr start)
  (can-jump arr start))