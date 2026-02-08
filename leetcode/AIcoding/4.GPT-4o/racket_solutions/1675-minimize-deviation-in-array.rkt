(define (minimumDeviation nums)
  (define (max-element lst) (apply max lst))
  (define (min-element lst) (apply min lst))

  (define nums (map (lambda (x) (if (even? x) x (* x 2))) nums))
  (define max-heap (make-heap (lambda (a b) (> a b)) nums))

  (define min-dev (abs (- (max-element nums) (min-element nums))))

  (let loop ()
    (if (empty? max-heap)
        min-dev
        (let* ((max-val (heap-extract max-heap))
               (dev (abs (- max-val (min-element max-heap)))))
          (set! min-dev (min min-dev dev))
          (if (even? max-val)
              (loop)
              min-dev)))))