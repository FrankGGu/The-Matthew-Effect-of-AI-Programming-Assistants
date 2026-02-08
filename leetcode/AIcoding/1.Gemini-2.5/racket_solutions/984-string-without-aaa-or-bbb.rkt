(define (strWithout3a3b a b)
  (let loop ((a a) (b b) (res '()) (len 0))
    (cond
      ;; Base case: both counts are zero, string is complete
      ((and (= a 0) (= b 0)) (list->string (reverse res)))

      ;; Priority 1: If the string ends with "bb", we must append 'a' (if available)
      ((and (> a 0)
            (>= len 2)
            (char=? (car res) #\b)
            (char=? (cadr res) #\b))
       (loop (- a 1) b (cons #\a res) (+ len 1)))

      ;; Priority 2: If the string ends with "aa", we must append 'b' (if available)
      ((and (> b 0)
            (>= len 2)
            (char=? (car res) #\a)
            (char=? (cadr res) #\a))
       (loop a (- b 1) (cons #\b res) (+ len 1)))

      ;; Priority 3: If 'a' count is strictly greater than 'b' count, append 'a' (if available)
      ((and (> a 0) (> a b))
       (loop (- a 1) b (cons #\a res) (+ len 1)))

      ;; Priority 4: If 'b' count is strictly greater than 'a' count, append 'b' (if available)
      ((and (> b 0) (> b a))
       (loop a (- b 1) (cons #\b res) (+ len 1)))

      ;; Priority 5: If counts are equal, append 'a' (arbitrary choice, 'b' would also work)
      ((and (> a 0) (= a b))
       (loop (- a 1) b (cons #\a res) (+ len 1)))

      ;; Priority 6: If only 'a's are left, append 'a'
      ((> a 0)
       (loop (- a 1) b (cons #\a res) (+ len 1)))

      ;; Priority 7: If only 'b's are left, append 'b'
      ((> b 0)
       (loop a (- b 1) (cons #\b res) (+ len 1)))

      ;; Fallback: This case should ideally not be reached if a solution always exists
      ;; and the conditions cover all possibilities where a or b > 0.
      (else (list->string (reverse res))))))