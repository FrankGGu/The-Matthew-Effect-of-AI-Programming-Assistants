#lang racket

(define (alert-usage log-file)
  (define (parse-time time-str)
    (let* ([parts (string-split time-str ":")]
           [hours (string->number (list-ref parts 0))]
           [minutes (string->number (list-ref parts 1))])
      (+ (* hours 60) minutes)))

  (define (process-log log)
    (for/fold ([prev-time -1] [count 0] [result '()])
              ([entry log])
      (let* ([name (car entry)]
             [time (parse-time (cadr entry))]
             [key (caddr entry)])
        (if (and (> count 0) (= name prev-name) (= key prev-key) (<= (- time prev-time) 59))
            (values name (+ count 1) (cons name result))
            (values name 1 (cons name result)))))

  (define (get-result log)
    (let ([sorted-log (sort log (lambda (a b) (< (parse-time (cadr a)) (parse-time (cadr b)))))]
          [result '()])
      (for/fold ([prev-name #f] [prev-key #f] [prev-time -1] [count 0] [result '()])
                ([entry sorted-log])
        (let* ([name (car entry)]
               [time (parse-time (cadr entry))]
               [key (caddr entry)])
          (if (and (equal? name prev-name) (equal? key prev-key) (<= (- time prev-time) 59))
              (values name key time (+ count 1) (if (> (+ count 1) 2) (cons name result) result))
              (values name key time 1 (if (> 1 2) result result))))))

  (define (get-names result)
    (remove-duplicates result))

  (define (main)
    (define log (map (lambda (s) (string-split s " ")) log-file))
    (define sorted-log (sort log (lambda (a b) (< (parse-time (cadr a)) (parse-time (cadr b))))))
    (define result (get-result sorted-log))
    (get-names result))

  (main))