(define/contract (alert-names key-name key-time)
  (-> (listof string?) (listof string?) (listof string?))
  (define (parse-time time-str)
    (let* ([parts (string-split time-str ":")]
           [hours (string->number (first parts))]
           [minutes (string->number (second parts))])
      (+ (* hours 60) minutes)))

  (define name-time-map (make-hash))
  (for ([name key-name] [time key-time])
    (hash-update! name-time-map name 
                  (lambda (times) (cons (parse-time time) times))
                  '()))

  (define alerted-names '())
  (hash-for-each name-time-map
                 (lambda (name times)
                   (let ([sorted-times (sort times <)])
                     (when (>= (length sorted-times) 3)
                       (let loop ([i 2])
                         (when (< i (length sorted-times))
                           (if (<= (- (list-ref sorted-times i) 
                                      (list-ref sorted-times (- i 2))) 60)
                               (set! alerted-names (cons name alerted-names))
                               (loop (+ i 1)))))))))
  (sort (remove-duplicates alerted-names) string<?))