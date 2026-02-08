#lang racket

(define (getDirections root startValue destValue)
  (define (find-path node target path)
    (when node
      (cond
        [(equal? (node-val node) target) (cons path '())]
        [else (or (find-path (left node) target (cons 'L path))
                  (find-path (right node) target (cons 'R path)))])))

  (define (build-path path)
    (apply string-append (reverse path)))

  (define start-path (find-path root startValue '()))
  (define dest-path (find-path root destValue '()))

  (define common-length (length (take-while (lambda (x) (equal? (first x) (first (second start-path))))
                                            (zip start-path dest-path))))

  (define up-steps (make-list (- (length start-path) common-length) 'U))
  (define down-steps (drop dest-path common-length))

  (build-path (append up-steps down-steps)))