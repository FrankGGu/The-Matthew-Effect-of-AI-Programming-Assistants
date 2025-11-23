(define request-times '())
(define time-limit 300)

(define (ping t)
  (set! request-times (filter (lambda (x) (>= t (- x time-limit))) request-times))
  (set! request-times (cons t request-times))
  (length request-times))

(define (RecentCounter)
  (let ((ping-func (lambda (t) (ping t))))
    ping-func))