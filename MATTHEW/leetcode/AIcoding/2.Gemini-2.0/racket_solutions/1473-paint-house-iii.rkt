(define (min-cost houses cost m n target)
  (define memo (make-hash))

  (define (solve index neighbors last-color)
    (if (= index m)
        (if (= neighbors target) 0 +inf.0)
        (if (> neighbors target) +inf.0
            (hash-ref! memo (list index neighbors last-color)
                       (lambda ()
                         (let loop ((color 1) (min-cost +inf.0))
                           (if (> color n)
                               min-cost
                               (let* ((new-neighbors (if (and (> index 0) (= color last-color))
                                                          neighbors
                                                          (+ neighbors 1)))
                                      (current-cost (+ (vector-ref (vector-ref cost index) (- color 1))
                                                       (solve (+ index 1) new-neighbors color))))
                                 (loop (+ color 1) (min min-cost current-cost)))))))))))

  (define (solve-first index neighbors)
    (if (= index m)
        (if (= neighbors target) 0 +inf.0)
        (if (> neighbors target) +inf.0
            (let loop ((color 1) (min-cost +inf.0))
              (if (> color n)
                  min-cost
                  (let ((current-cost (+ (vector-ref (vector-ref cost index) (- color 1))
                                          (solve (+ index 1) 1 color))))
                    (loop (+ color 1) (min min-cost current-cost))))))))

  (define (solve-precolored index neighbors last-color)
    (if (= index m)
        (if (= neighbors target) 0 +inf.0)
        (if (> neighbors target) +inf.0
            (hash-ref! memo (list index neighbors last-color)
                       (lambda ()
                         (let* ((house-color (vector-ref houses index)))
                           (if (= house-color 0)
                               (let loop ((color 1) (min-cost +inf.0))
                                 (if (> color n)
                                     min-cost
                                     (let* ((new-neighbors (if (and (> index 0) (= color last-color))
                                                                neighbors
                                                                (+ neighbors 1)))
                                             (current-cost (+ (vector-ref (vector-ref cost index) (- color 1))
                                                              (solve-precolored (+ index 1) new-neighbors color))))
                                       (loop (+ color 1) (min min-cost current-cost)))))
                               (let* ((new-neighbors (if (and (> index 0) (= house-color last-color))
                                                          neighbors
                                                          (+ neighbors 1)))
                                      (current-cost (solve-precolored (+ index 1) new-neighbors house-color)))
                                 current-cost))))))))

  (define (solve-first-precolored index neighbors)
    (if (= index m)
        (if (= neighbors target) 0 +inf.0)
        (if (> neighbors target) +inf.0
            (let* ((house-color (vector-ref houses index)))
              (if (= house-color 0)
                  (let loop ((color 1) (min-cost +inf.0))
                    (if (> color n)
                        min-cost
                        (let ((current-cost (+ (vector-ref (vector-ref cost index) (- color 1))
                                                (solve-precolored (+ index 1) 1 color))))
                          (loop (+ color 1) (min min-cost current-cost)))))
                  (solve-precolored (+ index 1) 1 house-color))))))

  (if (every? (lambda (x) (= x 0)) houses)
      (let ((result (solve-first 0 0)))
        (if (= result +inf.0) -1 result))
      (let ((result (solve-first-precolored 0 0)))
        (if (= result +inf.0) -1 result))))