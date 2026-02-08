(struct frequency-tracker (counts freq-counts) #:mutable)

(define (frequency-tracker-init)
  (frequency-tracker (make-hash) (make-hash)))

(define (frequency-tracker-add ft number)
  (let* ([counts (frequency-tracker-counts ft)]
         [freq-counts (frequency-tracker-freq-counts ft)]
         [old-count (hash-ref counts number 0)]
         [new-count (+ old-count 1)])

    (when (> old-count 0)
      (let ([current-freq-count (hash-ref freq-counts old-count 0)])
        (if (= current-freq-count 1)
            (hash-remove! freq-counts old-count)
            (hash-set! freq-counts old-count (- current-freq-count 1)))))

    (hash-set! counts number new-count)

    (let ([current-freq-count (hash-ref freq-counts new-count 0)])
      (hash-set! freq-counts new-count (+ current-freq-count 1)))))

(define (frequency-tracker-delete ft number)
  (let* ([counts (frequency-tracker-counts ft)]
         [freq-counts (frequency-tracker-freq-counts ft)]
         [old-count (hash-ref counts number 0)])

    (when (> old-count 0)
      (let* ([new-count (- old-count 1)])

        (let ([current-freq-count (hash-ref freq-counts old-count 0)])
          (if (= current-freq-count 1)
              (hash-remove! freq-counts old-count)
              (hash-set! freq-counts old-count (- current-freq-count 1))))

        (if (> new-count 0)
            (hash-set! counts number new-count)
            (hash-remove! counts number))

        (when (> new-count 0)
          (let ([current-freq-count (hash-ref freq-counts new-count 0)])
            (hash-set! freq-counts new-count (+ current-freq-count 1))))))))

(define (frequency-tracker-has-frequency ft frequency)
  (let ([freq-counts (frequency-tracker-freq-counts ft)])
    (> (hash-ref freq-counts frequency 0) 0)))