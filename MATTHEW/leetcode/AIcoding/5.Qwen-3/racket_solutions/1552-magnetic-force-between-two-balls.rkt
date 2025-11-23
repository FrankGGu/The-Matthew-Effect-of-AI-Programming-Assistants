#lang racket

(define (max-distance-arrangement position m)
  (define (can-place? positions mid)
    (let loop ((count 1) (prev (car positions)))
      (if (= count m)
          #t
          (let ((next (findf (lambda (p) (>= p (+ prev mid))) (cdr positions))))
            (if next
                (loop (+ count 1) next)
                #f)))))

  (define sorted (sort position <))
  (let loop ((low 1) (high (- (last sorted) (first sorted))))
    (if (> low high)
        high
        (let ((mid (quotient (+ low high) 2)))
          (if (can-place? sorted mid)
              (loop (+ mid 1) high)
              (loop low (- mid 1)))))))

(define (read-input)
  (let ((n (string->number (read-line)))
        (m (string->number (read-line))))
    (let ((positions (map string->number (string-split (read-line)))))
      (list n m positions)))

(define (main)
  (let* ((input (read-input))
         (n (car input))
         (m (cadr input))
         (positions (caddr input)))
    (display (max-distance-arrangement positions m))))

(main)