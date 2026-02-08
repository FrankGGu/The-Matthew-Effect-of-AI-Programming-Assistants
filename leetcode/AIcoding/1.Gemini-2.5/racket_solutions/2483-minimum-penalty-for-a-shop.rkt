(define (minimum-penalty customers)
  (let* ((n (string-length customers))
         ;; Calculate initial closed-penalty for j=0 (all customers are in the "closed" period)
         (initial-closed-penalty (for/sum ([i (in-range n)])
                                   (if (char=? (string-ref customers i) #\Y) 1 0))))

    ;; Use for/fold to iterate through possible closing hours (from 1 to n)
    ;; and maintain the minimum penalty and corresponding hour.
    ;; The fold state consists of:
    ;; 1. min-p: The minimum penalty found so far.
    ;; 2. best-h: The closing hour corresponding to min-p.
    ;; 3. open-p: Penalty from 'N's in the [0...j-1] range (shop open but no customer).
    ;; 4. closed-p: Penalty from 'Y's in the [j...n-1] range (shop closed but customer came).
    (let-values (((min-p-final best-h-final open-p-final closed-p-final)
                  (for/fold ([min-p initial-closed-penalty] ; Initial min penalty for j=0
                             [best-h 0]                     ; Initial best hour is 0
                             [open-p 0]                     ; Initial open penalty for j=0 is 0
                             [closed-p initial-closed-penalty]) ; Initial closed penalty for j=0
                            ([i (in-range n)]) ; Iterate through customer indices (0 to n-1)

                    ;; current-char is customers[i]. When processing customers[i],
                    ;; we are calculating the penalty for closing hour j = i+1.
                    (let* ((current-char (string-ref customers i))
                           ;; Update open-p based on current-char
                           (next-open-p (if (char=? current-char #\N)
                                            (+ open-p 1)
                                            open-p))
                           ;; Update closed-p based on current-char
                           (next-closed-p (if (char=? current-char #\Y)
                                              (- closed-p 1)
                                              closed-p))
                           ;; Calculate total penalty for the current closing hour (i+1)
                           (current-total-penalty (+ next-open-p next-closed-p))
                           (current-hour (+ i 1))) ; The closing hour j = i+1

                      ;; Compare current-total-penalty with min-p
                      ;; If current-total-penalty is strictly less, update min-p and best-h.
                      ;; If equal, we keep the smaller best-h (which is already stored due to strict inequality).
                      (if (< current-total-penalty min-p)
                          (values current-total-penalty current-hour next-open-p next-closed-p)
                          (values min-p best-h next-open-p next-closed-p))))))

      ;; The final best-h contains the minimum penalty closing hour
      best-h-final)))