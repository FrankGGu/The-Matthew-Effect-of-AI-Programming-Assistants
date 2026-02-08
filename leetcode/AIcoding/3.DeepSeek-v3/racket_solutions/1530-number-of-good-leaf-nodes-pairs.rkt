#lang racket

(define (count-pairs root distance)
  (define (dfs node)
    (if (null? node)
        (make-hash)
        (let* ([left (dfs (node-left node))]
               [right (dfs (node-right node))]
               [res (make-hash)])
          (if (and (null? (node-left node)) (null? (node-right node)))
              (begin (hash-set! res 1 1) res)
              (begin
                (for ([(d1 cnt1) (in-hash left)])
                  (for ([(d2 cnt2) (in-hash right)])
                    (when (<= (+ d1 d2) distance)
                      (set! ans (+ ans (* cnt1 cnt2))))))
                (for ([(d cnt) (in-hash left)])
                  (hash-set! res (+ d 1) cnt))
                (for ([(d cnt) (in-hash right)])
                  (hash-set! res (+ d 1) cnt))
                res)))))
  (define ans 0)
  (dfs root)
  ans)

(define (node-left node) (vector-ref node 1))
(define (node-right node) (vector-ref node 2))