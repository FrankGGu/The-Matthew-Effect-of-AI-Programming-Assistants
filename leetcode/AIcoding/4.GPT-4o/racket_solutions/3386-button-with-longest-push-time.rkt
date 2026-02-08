(define (longestPushTime buttons)
  (define (time-to-push button)
    (if (null? button) 0
        (+ (car button) (time-to-push (cdr button)))))
  (define (longest-time buttons)
    (if (null? buttons) 0
        (max (time-to-push (car buttons)) (longest-time (cdr buttons)))))
  (longest-time buttons))

(longestPushTime '((1 2) (2 3) (3 4)))