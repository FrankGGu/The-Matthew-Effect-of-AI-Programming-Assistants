#lang racket

(define (merge-interval new-L new-R existing-intervals)
  (let-values (((before-intervals overlapping-intervals after-intervals)
                (for/fold ((before '()) (overlapping '()) (after '()))
                          ((interval existing-intervals))
                  (let ((i-L (car interval))
                        (i-R (cdr interval)))
                    (cond
                      ;; Current interval is completely before the new [new-L, new-R]
                      ;; Add to 'before' list (will be reversed later)
                      ((< i-R new-L) (values (cons interval before) overlapping after))
                      ;; Current interval is completely after the new [new-L, new-R]
                      ;; Add to 'after' list (will be reversed later)
                      ((> i-L new-R) (values before overlapping (cons interval after)))
                      ;; Current interval overlaps with [new-L, new-R]
                      ;; Add to 'overlapping' list
                      (else (values before (cons interval overlapping) after)))))))
    ;; Calculate the merged interval from new-L, new-R and all overlapping intervals
    (let* ((merged-L (foldl (lambda (int acc) (min acc (car int))) new-L overlapping-intervals))
           (merged-R (foldl (lambda (int acc) (max acc (cdr int))) new-R overlapping-intervals)))
      ;; Reconstruct the sorted list of disjoint intervals
      ;; 'before-intervals' and 'after-intervals' were built in reverse order by for/fold, so reverse them back.
      (append (reverse before-intervals)
              (list (cons merged-L merged-R))
              (reverse after-intervals)))))

(define (total-colored-length operations)
  (let loop ((ops operations)
             (intervals '())) ; list of (start . end) pairs, sorted by start, disjoint
    (if (empty? ops)
        ;; All operations processed, calculate total length
        (apply + (map (lambda (p) (- (cdr p) (car p))) intervals))
        ;; Process next operation
        (let* ((op (car ops))
               (L (car op))
               (R (cadr op))) ; Assuming op is a list (L R)
          (loop (cdr ops) (merge-interval L R intervals))))))