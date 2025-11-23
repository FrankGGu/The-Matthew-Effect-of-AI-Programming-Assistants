#lang racket

(define (largest-magic-square grid)
  (let* ((m (length grid))
         (n (length (list-ref grid 0)))
         (vector-grid (build-vector m
                                    (lambda (i)
                                      (build-vector n
                                                    (lambda (j)
                                                      (list-ref (list-ref grid i) j))))))
         (row-prefix (build-vector m (lambda (i) (build-vector n (lambda (j) 0)))))
         (col-prefix (build-vector m (lambda (i) (build-vector n (lambda (j) 0))))))

    ;; Fill row-prefix sums
    (for ([i (in-range m)])
      (for ([j (in-range n)])
        (vector-set! (vector-ref row-prefix i) j
                     (+ (vector-ref (vector-ref vector-grid i) j)
                        (if (> j 0) (vector-ref (vector-ref row-prefix i) (- j 1)) 0)))))

    ;; Fill col-prefix sums
    (for ([j (in-range n)])
      (for ([i (in-range m)])
        (vector-set! (vector-ref col-prefix i) j
                     (+ (vector-ref (vector-ref vector-grid i) j)
                        (if (> i 0) (vector-ref (vector-ref col-prefix (- i 1)) j) 0)))))

    (define (get-row-sum r c1 c2)
      (- (vector-ref (vector-ref row-prefix r) c2)
         (if (> c1 0) (vector-ref (vector-ref row-prefix r) (- c1 1)) 0)))

    (define (get-col-sum r1 r2 c)
      (- (vector-ref (vector-ref col-prefix r2) c)
         (if (> r1 0) (vector-ref (vector-ref col-prefix (- r1 1)) c) 0)))

    (define (is-magic-square? r c k)
      (if (= k 1)
          #t
          (let* ((target-sum (get-row-sum r c (+ c k -1))))
            (and
             ;; Check all rows in subgrid
             (for/and ([i (in-range k)])
               (= (get-row-sum (+ r i) c (+ c k -1)) target-sum))
             ;; Check all columns in subgrid
             (for/and ([j (in-range k)])
               (= (get-col-sum r (+ r k -1) (+ c j)) target-sum))
             ;; Check main diagonal
             (= (for/sum ([i (in-range k)])
                  (vector-ref (vector-ref vector-grid (+ r i)) (+ c i)))
                target-sum)
             ;; Check anti-diagonal
             (= (for/sum ([i (in-range k)])
                  (vector-ref (vector-ref vector-grid (+ r i)) (+ c (- k 1 i))))
                target-sum)))))

    (let ((min-dim (min m n)))
      (for/or ([k (in-range min-dim 0 -1)]) ; Iterate k from min-dim down to 1
        (for/or ([r (in-range (- m k) -1 -1)]) ; Iterate r from m-k down to 0
          (for/or ([c (in-range (- n k) -1 -1)]) ; Iterate c from n-k down to 0
            (if (is-magic-square? r c k)
                k
                #f)))))))