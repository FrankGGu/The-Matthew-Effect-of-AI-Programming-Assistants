(define (calculate-finish-times arrival-times)
  (let loop ((cars arrival-times)
             (current-finish-time 0)
             (result '()))
    (if (empty? cars)
        (reverse result)
        (let* ((arrival (car cars))
               (finish-time (+ (max arrival current-finish-time) 1)))
          (loop (cdr cars)
                finish-time
                (cons finish-time result))))))

(define (solve input-data)
  ;; Assuming input-data is a list of arrival times
  ;; This function is a wrapper to match typical LeetCode submission structure
  ;; where the main logic might be inside a class or a specific function name.
  ;; For Racket, it's usually a single function that takes the input.
  (calculate-finish-times input-data))