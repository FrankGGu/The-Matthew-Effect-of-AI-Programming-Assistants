#lang racket

(define (make-union-find n)
  (define parent (build-vector n identity))
  (define rank (build-vector n (lambda (x) 0)))

  (define (find i)
    (if (= (vector-ref parent i) i)
        i
        (let ((root (find (vector-ref parent i))))
          (vector-set! parent i root)
          root)))

  (define (union i j)
    (let ((root-i (find i))
          (root-j (find j)))
      (if (= root-i root-j)
          #f
          (begin
            (let ((rank-i (vector-ref rank root-i))
                  (rank-j (vector-ref rank root-j)))
              (cond
                ((> rank-i rank-j) (vector-set! parent root-j root-i))
                ((< rank-i rank-j) (vector-set! parent root-i root-j))
                (else
                 (vector-set! parent root-j root-i)
                 (vector-set! rank root-i (+ rank-i 1)))))
            #t))))
  (list find union))

(define (kruskal n edges exclude-edge-idx force-include-edge)
  (define-values (find union) (make-union-find n))
  (define current-mst-weight 0)
  (define num-edges-in-mst 0)
  (define forced-edge-idx -1)

  (when force-include-edge
    (let ((w (car force-include-edge))
          (u (cadr force-include-edge))
          (v (caddr force-include-edge))
          (idx (cadddr force-include-edge)))
      (set! forced-edge-idx idx)
      (set! current-mst-weight (+ current-mst-weight w))
      (union u v)
      (set! num-edges-in-mst (+ num-edges-in-mst 1))))

  (define sorted-edges (sort edges (lambda (a b) (< (car a) (car b)))))

  (for-each (lambda (edge)
              (let ((w (car edge))
                    (u (cadr edge))
                    (v (caddr edge))
                    (idx (cadddr edge)))
                (unless (or (= idx exclude-edge-idx) (= idx forced-edge-idx))
                  (when (union u v)
                    (set! current-mst-weight (+ current-mst-weight w))
                    (set! num-edges-in-mst (+ num-edges-in-mst 1))))))
            sorted-edges)

  (list current-mst-weight num-edges-in-mst))

(define (find-critical-and-pseudo-critical-edges n edges-input)
  (define all-edges
    (for/list ([edge edges-input] [idx (in-naturals)])
      (list (list-ref edge 2) (list-ref edge 0) (list-ref edge 1) idx)))

  (define-values (min-mst-weight num-edges-in-ref-mst)
    (kruskal n all-edges -1 null))

  (define critical-edges (list))
  (define pseudo-critical-edges (list))

  (for-each (lambda (edge)
              (let ((idx (cadddr edge)))
                (define-values (mst-weight-without-edge num-edges-without-edge)
                  (kruskal n all-edges idx null))
                (when (or (> mst-weight-without-edge min-mst-weight)
                          (< num-edges-without-edge (- n 1)))
                  (set! critical-edges (cons idx critical-edges)))))
            all-edges)

  (for-each (lambda (edge)
              (let ((idx (cadddr edge)))
                (unless (member idx critical-edges)
                  (define-values (mst-weight-with-forced-edge num-edges-with-forced-edge)
                    (kruskal n all-edges -1 edge))
                  (when (= mst-weight-with-forced-edge min-mst-weight)
                    (set! pseudo-critical-edges (cons idx pseudo-critical-edges))))))
            all-edges)

  (list (sort critical-edges <) (sort pseudo-critical-edges <)))