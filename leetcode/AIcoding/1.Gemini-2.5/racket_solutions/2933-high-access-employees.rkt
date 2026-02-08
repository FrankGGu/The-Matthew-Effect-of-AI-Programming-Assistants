#lang racket

(define (high-access-employees accessTimes)

  (define (parse-time-to-minutes time-str)
    (let* ((parts (string-split time-str ":"))
           (hours (string->number (car parts)))
           (minutes (string->number (cadr parts))))
      (+ (* hours 60) minutes)))

  (define (check-high-access times)
    (if (< (length times) 3)
        #f
        (let loop ((i 0))
          (if (>= (+ i 2) (length times))
              #f
              (let ((t0 (list-ref times i))
                    (t2 (list-ref times (+ i 2))))
                (if (<= (- t2 t0) 59)
                    #t
                    (loop (+ i 1))))))))

  (define employee-access-map (make-hash))
  (for-each (lambda (access)
              (let* ((name (car access))
                     (time-str (cadr access))
                     (minutes (parse-time-to-minutes time-str)))
                (hash-set! employee-access-map name
                           (cons minutes (hash-ref employee-access-map name '())))))
            accessTimes)

  (define high-access-names-list '())
  (hash-for-each (lambda (name times)
                   (let ((sorted-times (sort times <)))
                     (when (check-high-access sorted-times)
                       (set! high-access-names-list (cons name high-access-names-list)))))
                 employee-access-map)

  (sort (remove-duplicates high-access-names-list) string<?))