#lang racket

(define (largest-multiple-of-three digits)
  ;; Count digit occurrences
  (define counts (make-vector 10 0))
  (for-each (lambda (d) (vector-set! counts d (+ (vector-ref counts d) 1))) digits)

  ;; Calculate total sum of digits
  (define total-sum (apply + digits))

  ;; Function to get a list of available digits of a certain remainder type, sorted ascending
  ;; rem-val should be 1 or 2
  (define (get-available-digits-by-rem rem-val)
    (let loop ((d rem-val) (acc '()))
      (if (> d 9)
          (sort acc <) ; Ensure ascending order
          (let ((current-d-count (vector-ref counts d)))
            (loop (+ d 3) (append acc (make-list current-d-count d)))))))

  ;; Get lists of available digits for remainder 1 and 2, sorted ascending
  (define rem1-available (get-available-digits-by-rem 1))
  (define rem2-available (get-available-digits-by-rem 2))

  ;; Function to remove k occurrences of a digit d from the counts vector
  (define (remove-digit! d k)
    (vector-set! counts d (max 0 (- (vector-ref counts d) k))))

  ;; Determine which digits to remove based on total-sum's remainder
  (cond
    ((= (remainder total-sum 3) 1)
     ;; Sum % 3 == 1. Need to remove digits whose sum % 3 == 1.
     ;; Option 1: Remove one smallest digit with remainder 1.
     (if (not (null? rem1-available))
         (remove-digit! (car rem1-available) 1)
         ;; Option 2: If no single rem1 digit, try removing two smallest digits with remainder 2.
         (if (>= (length rem2-available) 2)
             (begin
               (remove-digit! (car rem2-available) 1)
               (remove-digit! (cadr rem2-available) 1))
             ;; If neither option is possible, no multiple of 3 can be formed.
             ;; Clear all digits by setting counts to zero.
             (set! counts (make-vector 10 0)))))

    ((= (remainder total-sum 3) 2)
     ;; Sum % 3 == 2. Need to remove digits whose sum % 3 == 2.
     ;; Option 1: Remove one smallest digit with remainder 2.
     (if (not (null? rem2-available))
         (remove-digit! (car rem2-available) 1)
         ;; Option 2: If no single rem2 digit, try removing two smallest digits with remainder 1.
         (if (>= (length rem1-available) 2)
             (begin
               (remove-digit! (car rem1-available) 1)
               (remove-digit! (cadr rem1-available) 1))
             ;; If neither option is possible, no multiple of 3 can be formed.
             ;; Clear all digits by setting counts to zero.
             (set! counts (make-vector 10 0))))))

  ;; Reconstruct the number from the remaining digits
  (define result-digits '())
  ;; Iterate from 9 down to 0 to get digits in descending order
  (for-each (lambda (d)
              (let loop ((k (vector-ref counts d)))
                (when (> k 0)
                  (set! result-digits (cons d result-digits))
                  (loop (- k 1)))))
            (range 9 -1 -1))

  ;; Handle special cases for the final string
  (cond
    ((null? result-digits) "") ; No digits left, no multiple of 3 can be formed
    ;; If the first digit is 0 and there are other digits (e.g., [0,0,0]), return "0".
    ;; If it's just [0], it will fall to else and correctly return "0".
    ((and (= (car result-digits) 0) (> (length result-digits) 1)) "0")
    (else (string-join (map number->string result-digits) ""))))