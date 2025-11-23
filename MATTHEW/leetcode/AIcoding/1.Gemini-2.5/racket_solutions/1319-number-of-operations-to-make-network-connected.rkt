#lang racket

(struct dsu (parent num-components) #:mutable)

(define (make-dsu n)
  (dsu (build-vector n (lambda (i) i)) n))

(define (find dsu-obj i)
  (let ([parent-vec (dsu-parent dsu-obj)])
    (let loop ([curr i])
      (let ([p (vector-ref parent-vec curr)])
        (cond
          [(= p curr) curr]
          [else
           (let ([root (loop p)])
             (vector-set! parent-vec curr root)
             root)])))))

(define (union dsu-obj i j)
  (let ([root-i (find dsu-obj i)])
    (let ([root-j (find dsu-obj j)])
      (unless (= root-i root-j)
        (vector-set! (dsu-parent dsu-obj) root-j root-i)
        (set-dsu-num-components! dsu-obj (- (dsu-num-components dsu-obj) 1))))))

(define (num-operations-to-make-network-connected n connections)
  (if (< (length connections) (- n 1))
      -1
      (let ([dsu-obj (make-dsu n)])
        (for-each (lambda (conn)
                    (union dsu-obj (car conn) (cadr conn)))
                  connections)
        (- (dsu-num-components dsu-obj) 1))))