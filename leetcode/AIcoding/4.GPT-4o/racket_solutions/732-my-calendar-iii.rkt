(define MyCalendarThree
  (class object%
    (super-new)
    (define/override (instantiate)
      (set! events (make-hash)))
    (define events (make-hash))

    (define (book start end)
      (hash-set! events start (add1 (hash-ref events start 0)))
      (hash-set! events end (add1 (hash-ref events end 0)))
      (define max 0)
      (define current 0)
      (for-each (lambda (key)
                  (define count (hash-ref events key 0))
                  (set! current (+ current count))
                  (set! max (max max current)))
                (hash-keys events))
      max)

    (define/public (book start end)
      (book start end))
  ))