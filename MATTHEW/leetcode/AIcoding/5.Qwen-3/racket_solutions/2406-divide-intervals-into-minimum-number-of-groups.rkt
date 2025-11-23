(define (greatest-common-divisor a b)
  (if (= b 0)
      a
      (greatest-common-divisor b (modulo a b))))

(define (least-common-multiple a b)
  (/ (* a b) (greatest-common-divisor a b)))

(define (min-groups intervals)
  (define (compare-interval a b)
    (if (< (car a) (car b))
        -1
        (if (> (car a) (car b))
            1
            0)))
  (define sorted (sort intervals compare-interval))
  (define (helper intervals groups)
    (cond ((null? intervals) (length groups))
          ((null? groups) (helper (cdr intervals) (list (list (car intervals)))))
          (else
           (let ((current (car intervals)))
             (let loop ((i 0) (groups groups))
               (if (>= i (length groups))
                   (helper (cdr intervals) (append groups (list (list current))))
                   (let ((group (list-ref groups i)))
                     (if (<= (cadr current) (car group))
                         (helper (cdr intervals) (append (take groups i) (list (cons current group)) (drop groups (+ i 1))))
                         (loop (+ i 1) groups)))))))))
  (helper sorted '()))