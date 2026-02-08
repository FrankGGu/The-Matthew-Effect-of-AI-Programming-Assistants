#lang racket

(define (count-ways-to-group-overlapping-ranges ranges)
  (define MOD 1000000007)

  (define (modular-expt base exp modulus)
    (cond
      [(= exp 0) 1]
      [(even? exp)
       (let ([half (modular-expt base (quotient exp 2) modulus)])
         (remainder (* half half) modulus))]
      [else
       (remainder (* base (modular-expt base (- exp 1) modulus)) modulus)]))

  (define sorted-ranges (sort ranges (lambda (r1 r2) (< (car r1) (car r2)))))

  (if (null? sorted-ranges)
      1
      (let* ((first-range (car sorted-ranges))
             (initial-end (cadr first-range)))
        (let loop ((remaining (cdr sorted-ranges))
                   (disjoint-count 1)
                   (current-end initial-end))
          (if (null? remaining)
              (modular-expt 2 disjoint-count MOD)
              (let* ((range (car remaining))
                     (start (car range))
                     (end (cadr range)))
                (if (> start current-end)
                    (loop (cdr remaining)
                          (+ disjoint-count 1)
                          end)
                    (loop (cdr remaining)
                          disjoint-count
                          (max current-end end))))))))