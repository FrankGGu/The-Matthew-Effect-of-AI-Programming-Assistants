#lang racket

(require data/hash-set)

(define (count-artifacts n artifacts dig)
  (define dug-cells-set (make-hash-set))

  (for-each (lambda (cell)
              (hash-set-add! dug-cells-set cell))
            dig)

  (define dig-length (length dig))

  (define (artifact-fully-dug? artifact)
    (let* ((r1 (car artifact))
           (c1 (cadr artifact))
           (r2 (caddr artifact))
           (c2 (cadddr artifact)))
      (let ((num-cells-in-artifact (* (+ (- r2 r1) 1) (+ (- c2 c1) 1))))
        (if (> num-cells-in-artifact dig-length)
            #f
            (for/and ((r (in-range r1 (+ r2 1))))
              (for/and ((c (in-range c1 (+ c2 1))))
                (hash-set-contains? dug-cells-set (list r c))))))))

  (define extracted-artifact-count 0)

  (for-each (lambda (artifact)
              (when (artifact-fully-dug? artifact)
                (set! extracted-artifact-count (+ extracted-artifact-count 1))))
            artifacts)

  extracted-artifact-count)