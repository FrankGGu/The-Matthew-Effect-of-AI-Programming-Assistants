#lang racket

(define (minimum-cost start target special-roads)
  (define (manhattan p1 p2)
    (+ (abs (- (car p1) (car p2))) (abs (- (cdr p1) (cdr p2)))))

  (define (get-neighbors node)
    (define (add-special-neighbors)
      (for/list ([road special-roads])
        (define x1 (car (car road)))
        (define y1 (cdr (car road)))
        (define x2 (car (cdr road)))
        (define y2 (cdr (cdr road)))
        (define cost (caddr road))
        (list (cons x2 y2) (+ (manhattan node (cons x1 y1)) cost))))

    (define direct (list (list target (manhattan node target))))
    (append direct (add-special-neighbors)))

  (define (dijkstra)
    (define heap (make-heap (lambda (a b) (< (cadr a) (cadr b)))))
    (heap-add! heap (list start 0))
    (define visited (make-hash))

    (let loop ()
      (if (heap-empty? heap)
          (manhattan start target)
          (let* ([current (heap-min heap)]
                 [node (car current)]
                 [current-cost (cadr current)])
            (heap-remove! heap)
            (if (equal? node target)
                current-cost
                (if (hash-has-key? visited node)
                    (loop)
                    (begin
                      (hash-set! visited node #t)
                      (for ([neighbor (get-neighbors node)])
                        (define neighbor-node (car neighbor))
                        (define neighbor-cost (+ current-cost (cadr neighbor)))
                        (if (not (hash-has-key? visited neighbor-node))
                            (heap-add! heap (list neighbor-node neighbor-cost))
                            (void)))
                      (loop))))))))

  (dijkstra))