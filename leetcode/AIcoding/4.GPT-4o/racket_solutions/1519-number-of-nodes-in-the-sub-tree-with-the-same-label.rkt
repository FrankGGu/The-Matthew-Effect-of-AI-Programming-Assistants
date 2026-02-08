#lang racket

(define (countSubTrees n edges labels)
  (define graph (make-vector n))
  (for ([edge edges])
    (let ([u (car edge)]
          [v (cadr edge)])
      (vector-set! graph u (cons v (vector-ref graph u)))
      (vector-set! graph v (cons u (vector-ref graph v)))))

  (define counts (make-vector n 0))
  (define visited (make-vector n #f))

  (define (dfs node)
    (set! visited (vector-set! visited node #t))
    (define label (string-ref labels node))
    (define local-count (make-hash))

    (for ([neighbor (vector-ref graph node)])
      (when (not (vector-ref visited neighbor))
        (let ([sub-count (dfs neighbor)])
          (for ([label (hash-keys sub-count)])
            (hash-set! local-count label (+ (hash-ref local-count label 0) (hash-ref sub-count label 0))))))
      )
    (hash-set! local-count label (+ (hash-ref local-count label 0) 1))
    (vector-set! counts node local-count)
    local-count)

  (dfs 0)

  (define result (make-vector n 0))
  (for ([i (in-range n)])
    (set! result (vector-set! result i (hash-ref (vector-ref counts i) (string-ref labels i) 0))))
  (vector->list result))

(define (countSubTreesWrapper n edges labels)
  (countSubTrees n edges (map (lambda (x) (string->list (string x))) labels)))