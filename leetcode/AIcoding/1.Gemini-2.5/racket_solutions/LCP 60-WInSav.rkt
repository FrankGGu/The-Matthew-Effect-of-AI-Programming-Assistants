#lang racket

(define (group-consecutive lst)
  (if (empty? lst)
      '()
      (let loop ((remaining (cdr lst))
                 (current-item (car lst))
                 (current-count 1)
                 (acc '()))
        (if (empty? remaining)
            (reverse (cons (list current-item current-count) acc))
            (let ((next-item (car remaining)))
              (if (equal? next-item current-item)
                  (loop (cdr remaining) current-item (+ current-count 1) acc)
                  (loop (cdr remaining)
                        next-item
                        1
                        (cons (list current-item current-count) acc))))))))

(define (remove-pops lst min-pop-size)
  (let ((grouped (group-consecutive lst)))
    (apply append
           (map (lambda (segment)
                  (let ((item (car segment))
                        (count (cadr segment)))
                    (if (>= count min-pop-size)
                        '()
                        (build-list count (lambda (_) item)))))
                grouped))))

(define (solve items)
  (let ((min-pop-size 3))
    (let loop ((current-items items))
      (let ((next-items (remove-pops current-items min-pop-size)))
        (if (equal? next-items current-items)
            current-items
            (loop next-items))))))