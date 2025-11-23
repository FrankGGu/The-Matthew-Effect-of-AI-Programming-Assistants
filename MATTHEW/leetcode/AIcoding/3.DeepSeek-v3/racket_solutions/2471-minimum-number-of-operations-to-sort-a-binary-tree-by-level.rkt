#lang racket

(define/contract (minimum-operations root)
  (-> (or/c null? (listof exact-integer?)) exact-integer?)
  (if (null? root) 0
      (let loop ([nodes (list root)] [res 0])
        (if (null? nodes) res
            (let* ([vals (map (lambda (n) (if (null? n) null (car n))) nodes)]
                   [sorted (sort vals <)]
                   [swaps (let ([pos (make-hash)])
                            (for ([i (in-naturals)] [v vals]) (hash-set! pos v i))
                            (let ([visited (make-hash)] [count 0])
                              (for ([i (in-naturals)] [v vals])
                                (unless (hash-ref visited i #f)
                                  (let cycle ([j i] [cycle-size 0])
                                    (if (hash-ref visited j #f)
                                        (set! count (+ count (- cycle-size 1)))
                                        (begin
                                          (hash-set! visited j #t)
                                          (cycle (hash-ref pos (list-ref sorted j)) (add1 cycle-size)))))))
                              count)])
                   [next-nodes (append* (map (lambda (n) (if (null? n) null (cdr n))) nodes))])
              (loop next-nodes (+ res swaps)))))))