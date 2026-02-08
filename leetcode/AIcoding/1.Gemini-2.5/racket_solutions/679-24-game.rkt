(define (can-get-24? nums)
  (define epsilon 0.001)

  (define (get-remaining lst idx1 idx2)
    (let loop ([k 0] [current-lst lst] [acc '()])
      (if (null? current-lst)
          (reverse acc)
          (loop (add1 k)
                (cdr current-lst)
                (if (or (= k idx1) (= k idx2))
                    acc
                    (cons (car current-lst) acc))))))

  (define (helper current-nums)
    (cond
      [(= (length current-nums) 1)
       (<= (abs (- (car current-nums) 24.0)) epsilon)]
      [else
       (for/or ([i (range (length current-nums))])
         (for/or ([j (range (add1 i) (length current-nums))])
           (let* ([num1 (list-ref current-nums i)]
                  [num2 (list-ref current-nums j)]
                  [remaining (get-remaining current-nums i j)])
             (let ([possible-results
                    (append
                     (list (+ num1 num2)
                           (- num1 num2)
                           (- num2 num1)
                           (* num1 num2))
                     (if (not (zero? num2)) (list (/ num1 num2)) '())
                     (if (not (zero? num1)) (list (/ num2 num1)) '()))])

               (for/or ([res possible-results])
                 (helper (cons res remaining)))))))]))

  (helper (map (lambda (x) (inexact x)) nums)))