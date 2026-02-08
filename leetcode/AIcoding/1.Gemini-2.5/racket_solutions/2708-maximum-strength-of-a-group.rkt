(define (remove-one item lst)
  (let loop ([current-lst lst] [found #f] [acc '()])
    (cond
      [(empty? current-lst) (reverse acc)]
      [(and (not found) (= (car current-lst) item))
       (loop (cdr current-lst) #t acc)]
      [else
       (loop (cdr current-lst) found (cons (car current-lst) acc))])))

(define (maximum-strength-of-a-group nums)
  (let* ([non-zeros (filter (lambda (x) (not (= x 0))) nums)]
         [num-zeros (length (filter (lambda (x) (= x 0)) nums))]
         [negatives (filter (lambda (x) (< x 0)) non-zeros)])

    (cond
      ;; Case 1: All numbers are zeros.
      ;; The only possible group is a single 0, with strength 0.
      [(empty? non-zeros) 0]

      ;; Case 2: Only one non-zero number, and it's negative.
      ;; Examples: [-5], [-5, 0].
      ;; If there are zeros, taking a 0 results in strength 0, which is better than a negative product.
      ;; If no zeros, the single negative number is the only option.
      [(and (= (length non-zeros) 1)
            (< (first non-zeros) 0))
       (if (> num-zeros 0)
           0
           (first non-zeros))]

      ;; Case 3: All other scenarios.
      ;; This includes:
      ;; - One positive non-zero number (e.g., [5], [5, 0]).
      ;; - Multiple non-zero numbers (e.g., [1, 2], [-1, -2], [1, -1, -2], [-1, -2, -3]).
      [else
       (let ([product-all-non-zeros (foldl * 1 non-zeros)])
         (if (> product-all-non-zeros 0)
             ;; If the product of all non-zeros is positive, this is the maximum.
             product-all-non-zeros
             ;; If the product of all non-zeros is negative, it means there's an odd count of negative numbers.
             ;; To maximize the product (make it positive), we must remove one negative number.
             ;; We remove the negative number closest to zero (i.e., the largest negative number).
             (let* ([sorted-negatives (sort negatives <)]
                    [largest-negative (last sorted-negatives)]
                    [non-zeros-without-largest-negative (remove-one largest-negative non-zeros)])
               ;; The resulting list will always have at least one element because:
               ;; - We are in the 'else' branch, implying (length non-zeros) > 1 OR (first non-zeros) > 0.
               ;; - If (length non-zeros) = 1, it must be positive (handled by Case 2 if negative).
               ;; - If (length non-zeros) > 1, removing one element still leaves at least one.
               (foldl * 1 non-zeros-without-largest-negative))))])))