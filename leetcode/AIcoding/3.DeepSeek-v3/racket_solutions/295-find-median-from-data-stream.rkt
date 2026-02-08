(define median-finder%
  (class object%
    (super-new)
    (init-field)
    (define max-heap (make-heap (lambda (a b) (> a b))))
    (define min-heap (make-heap (lambda (a b) (< a b))))

    (define/public (add-num num)
      (heap-add! max-heap num)
      (heap-add! min-heap (heap-extremum max-heap))
      (heap-remove-max! max-heap)
      (when (< (heap-count max-heap) (heap-count min-heap))
        (heap-add! max-heap (heap-extremum min-heap))
        (heap-remove-max! min-heap)))

    (define/public (find-median)
      (if (> (heap-count max-heap) (heap-count min-heap))
          (heap-extremum max-heap)
          (/ (+ (heap-extremum max-heap) (heap-extremum min-heap)) 2.0))))

(define (make-heap cmp)
  (let ([heap '()])
    (lambda (msg . args)
      (case msg
        [(add!) (set! heap (heap-insert heap (car args) cmp))]
        [(remove-max!) (set! heap (heap-remove heap cmp))]
        [(count) (length heap)]
        [(extremum) (if (null? heap) +inf.0 (car heap))]
        [else (error "Unknown message")]))))

(define (heap-insert heap val cmp)
  (let loop ([heap heap])
    (if (null? heap)
        (list val)
        (let ([root (car heap)]
              [rest (cdr heap)])
          (if (cmp val root)
              (cons val (cons root rest))
              (cons root (loop rest))))))

(define (heap-remove heap cmp)
  (if (null? heap)
      '()
      (let ([rest (cdr heap)])
        (if (null? rest)
            '()
            (let ([first (car rest)]
                  [second (cadr rest)]
                  [rest-rest (cddr rest)])
              (if (cmp first second)
                  (cons first (heap-remove (cons second rest-rest) cmp))
                  (cons second (heap-remove (cons first rest-rest) cmp)))))))

(define (heap-add! heap val)
  (heap 'add! val))

(define (heap-remove-max! heap)
  (heap 'remove-max!))

(define (heap-count heap)
  (heap 'count))

(define (heap-extremum heap)
  (heap 'extremum))