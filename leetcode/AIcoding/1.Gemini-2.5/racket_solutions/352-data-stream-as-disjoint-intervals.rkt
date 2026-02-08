#lang racket

(struct summary-ranges (intervals) #:mutable)

(define (summary-ranges-init)
  (summary-ranges (list)))

(define (insert-and-merge intervals val)
  (cond
    ((empty? intervals)
     (list (list val val)))

    (else
     (let* ((first-interval (car intervals))
            (rest-intervals (cdr intervals))
            (start (car first-interval))
            (end (cadr first-interval)))

       (cond
         ((> start (add1 val))
          (cons (list val val) intervals))

         ((< end (sub1 val))
          (cons first-interval (insert-and-merge rest-intervals val)))

         (else
          (let ((merged-start (min start val))
                (merged-end (max end val)))
            (let loop ((current-end merged-end)
                       (remaining-intervals rest-intervals))
              (cond
                ((empty? remaining-intervals)
                 (list (list merged-start current-end)))
                (else
                 (let* ((next-interval (car remaining-intervals))
                        (next-start (car next-interval))
                        (next-end (cadr next-interval)))
                   (if (<= next-start (add1 current-end))
                       (loop (max current-end next-end) (cdr remaining-intervals))
                       (cons (list merged-start current-end) remaining-intervals))))))))))))

(define (summary-ranges-add-num sr val)
  (set-summary-ranges-intervals! sr (insert-and-merge (summary-ranges-intervals sr) val)))

(define (summary-ranges-get-intervals sr)
  (summary-ranges-intervals sr))