(define (countPairs time)
  (define (hour-minutes time)
    (map (lambda (x) (if (< x 10) (string-append "0" (number->string x)) (number->string x))) (map string->number (string-split time ":"))))

  (define (time-to-minutes time)
    (let* ((h (string->number (substring time 0 2)))
           (m (string->number (substring time 3 5))))
      (+ (* h 60) m)))

  (define time-count (make-hash))

  (for-each (lambda (t)
              (let ((minutes (time-to-minutes t)))
                (hash-set! time-count minutes (+ 1 (hash-ref time-count minutes 0)))))
            time)

  (let loop ((result 0) (i 0))
    (if (< i 1440)
        (let ((target (modulo (+ i 720) 1440)))
          (loop (+ result (* (hash-ref time-count i 0) (hash-ref time-count target 0))) (+ i 1)))
        result)))

(define (countPairs time)
  (countPairs time))