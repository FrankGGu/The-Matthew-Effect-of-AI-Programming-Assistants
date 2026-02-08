(define (garbage-collection garbage travel)
  (define total-time (apply + (map string-length garbage)))
  (define (sum-travel travel)
    (if (null? travel)
        0
        (+ (car travel) (sum-travel (cdr travel)))))
  (define total-travel (apply + (map sum-travel (map list travel (cdr travel)))))
  (+ total-time total-travel))

(define (minTimeToCollectGarbage garbage travel)
  (define last-index (sub1 (length travel)))
  (garbage-collection (if (null? travel) garbage (append garbage (list (car (last travel))))) (if (null? travel) '() (append travel (list 0)))))
)