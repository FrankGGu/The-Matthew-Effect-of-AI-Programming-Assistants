(define sequentially-ordinal-rank-tracker%
  (class object%
    (super-new)
    (init-field)
    (define min-heap (make-heap (lambda (a b) (string<? (car a) (car b)))))
    (define max-heap (make-heap (lambda (a b) (string>? (car a) (car b)))))
    (define count 0)

    (define/public (add name score)
      (heap-add! min-heap (cons name score))
      (define moved (heap-remove-min! min-heap))
      (heap-add! max-heap moved)
      (when (> (heap-count max-heap) count)
        (define moved-back (heap-remove-min! max-heap))
        (heap-add! min-heap moved-back)))

    (define/public (get)
      (set! count (+ count 1))
      (define result (heap-min max-heap))
      (heap-remove-min! max-heap)
      (when (not (zero? (heap-count min-heap)))
        (define moved (heap-remove-min! min-heap))
        (heap-add! max-heap moved))
      (car result))))

(define (make-heap cmp)
  (let ([heap '()])
    (lambda (msg . args)
      (case msg
        [(add!) (set! heap (heap-insert heap (car args) cmp))]
        [(remove-min!) 
         (let ([min (car heap)])
           (set! heap (heap-delete heap cmp))
           min)]
        [(min) (car heap)]
        [(count) (length heap)]
        [else (error "unknown message")]))))

(define (heap-insert heap item cmp)
  (let loop ([heap heap])
    (if (null? heap)
        (list item)
        (let ([root (car heap)]
              [rest (cdr heap)])
          (if (cmp item root)
              (cons item heap)
              (cons root (loop rest)))))))

(define (heap-delete heap cmp)
  (if (null? (cdr heap))
      '()
      (let ([root (car heap)]
            [rest (cdr heap)])
        (heap-insert rest (car (last-pair rest)) cmp))))

(define (last-pair lst)
  (if (null? (cdr lst))
      lst
      (last-pair (cdr lst))))