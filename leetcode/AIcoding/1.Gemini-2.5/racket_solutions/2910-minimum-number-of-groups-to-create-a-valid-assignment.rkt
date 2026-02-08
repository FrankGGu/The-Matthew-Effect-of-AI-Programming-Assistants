(define (minimum-number-of-groups-to-create-a-valid-assignment nums)
  (let* ((max-val (apply max nums))
         (low 1)
         (high max-val)
         (ans high)) ; Initialize ans with the largest possible k

    ;; Helper function to check if 'k' groups are possible for all item types
    ;; for some global 'x'.
    (define (check k)
      (let* ((first-count (car nums))
             ;; Calculate the required range [min_x, max_x] for the first item type.
             ;; min_x for a count 'c' and 'k' groups is max(0, ceil((c - k) / k)).
             ;; max_x for a count 'c' and 'k' groups is floor(c / k).
             (initial-min-x (max 0 (ceiling (- (/ first-count k) 1))))
             (initial-max-x (floor (/ first-count k))))

        ;; Iterate through the rest of the numbers to find the overall common x range.
        (let loop ((remaining-nums (cdr nums))
                   (current-min-x initial-min-x)
                   (current-max-x initial-max-x))
          (if (null? remaining-nums)
              ;; If all numbers processed, check if the overall range is valid.
              (<= current-min-x current-max-x)
              (let* ((count (car remaining-nums))
                     (min-x-for-this-count (max 0 (ceiling (- (/ count k) 1))))
                     (max-x-for-this-count (floor (/ count k))))

                ;; Update the overall common x range by taking the maximum of lower bounds
                ;; and minimum of upper bounds.
                (loop (cdr remaining-nums)
                      (max current-min-x min-x-for-this-count)
                      (min current-max-x max-x-for-this-count)))))))

    ;; Binary search for the minimum k.
    (let binary-search ((l low) (h high) (result ans))
      (if (> l h)
          result
          (let* ((mid (+ l (quotient (- h l) 2)))) ; Use quotient for integer division.
            (if (check mid)
                (binary-search l (- mid 1) mid) ; 'mid' is possible, try smaller k.
                (binary-search (+ mid 1) h result)))))))