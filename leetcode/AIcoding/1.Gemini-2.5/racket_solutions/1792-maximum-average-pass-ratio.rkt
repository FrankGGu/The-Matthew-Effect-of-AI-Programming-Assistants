#lang racket
(require data/heap)

(define (maximum-average-pass-ratio classes extraStudents)
  (define (calculate-increase p t)
    (- (/ (+ p 1.0) (+ t 1.0)) (/ p 1.0 t 1.0)))

  (define pq (make-heap (lambda (a b) (> (car a) (car b)))))

  (for-each
   (lambda (class-list)
     (let ((p (first class-list))
           (t (second class-list)))
       (heap-insert! pq (list (calculate-increase p t) p t))))
   classes)

  (for ([_ (in-range extraStudents)])
    (let* ((top-item (heap-extract-max! pq))
           (current-p (second top-item))
           (current-t (third top-item))
           (new-p (+ current-p 1))
           (new-t (+ current-t 1)))
      (heap-insert! pq (list (calculate-increase new-p new-t) new-p new-t))))

  (define total-ratio 0.0)
  (define num-classes (heap-count pq))

  (for ([_ (in-range num-classes)])
    (let* ((item (heap-extract-max! pq))
           (p (second item))
           (t (third item)))
      (set! total-ratio (+ total-ratio (/ p 1.0 t 1.0)))))

  (/ total-ratio num-classes))