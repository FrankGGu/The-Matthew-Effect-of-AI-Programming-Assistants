#lang racket

(define (make-dsu n)
  (define parent (build-vector (+ n 1) (lambda (i) i)))
  (define ranks (build-vector (+ n 1) (lambda (i) 0)))

  (define (find i)
    (if (= (vector-ref parent i) i)
        i
        (let ((root (find (vector-ref parent i))))
          (vector-set! parent i root)
          root)))

  (define (union i j)
    (let ((root-i (find i))
          (root-j (find j)))
      (unless (= root-i root-j)
        (let ((rank-i (vector-ref ranks root-i))
              (rank-j (vector-ref ranks root-j)))
          (cond
            ((> rank-i rank-j) (vector-set! parent root-j root-i))
            ((< rank-i rank-j) (vector-set! parent root-i root-j))
            (else
             (vector-set! parent root-j root-i)
             (vector-set! ranks root-i (+ rank-i 1))))))))
  (list find union))

(define (are-connected n threshold queries)
  (let ((dsu (make-dsu n)))
    (define find (car dsu))
    (define union (cadr dsu))

    (for ((g (in-range (+ threshold 1) (+ n 1))))
      (let ((first-multiple g))
        (for ((m (in-range (* 2 g) (+ n 1) g)))
          (union first-multiple m))))

    (map (lambda (query)
           (let ((cityA (car query))
                 (cityB (cadr query)))
             (= (find cityA) (find cityB))))
         queries)))