#lang racket

(define (calc-equation equations values queries)
  (define graph (make-hash))

  ;; Build the graph
  (for ([i (in-range (length equations))])
    (define equation (list-ref equations i))
    (define val (list-ref values i))
    (define num (list-ref equation 0))
    (define den (list-ref equation 1))

    (unless (hash-has-key? graph num)
      (hash-set! graph num (make-hash)))
    (unless (hash-has-key? graph den)
      (hash-set! graph den (make-hash)))

    (hash-set! (hash-ref graph num) den val)
    (hash-set! (hash-ref graph den) num (/ 1.0 val)))

  (define (dfs start-node end-node current-product visited)
    (cond
      [(equal? start-node end-node) current-product]
      [(hash-has-key? visited start-node) -1.0]
      [else
       (hash-set! visited start-node #t)
       (define neighbors (hash-ref graph start-node (make-hash)))
       (define result -1.0)
       (for ([(neighbor-node neighbor-val) (in-hash neighbors)])
         (unless (hash-has-key? visited neighbor-node)
           (set! result (dfs neighbor-node end-node (* current-product neighbor-val) visited))
           (when (not (= result -1.0))
             (break))))
       (hash-remove! visited start-node)
       result]))

  (define results (make-list (length queries) 0.0))

  (for ([i (in-range (length queries))])
    (define query (list-ref queries i))
    (define num (list-ref query 0))
    (define den (list-ref query 1))

    (cond
      [(or (not (hash-has-key? graph num)) (not (hash-has-key? graph den)))
       (list-set! results i -1.0)]
      [(equal? num den)
       (if (hash-has-key? graph num)
           (list-set! results i 1.0)
           (list-set! results i -1.0))]
      [else
       (list-set! results i (dfs num den 1.0 (make-hash)))]))
  results)