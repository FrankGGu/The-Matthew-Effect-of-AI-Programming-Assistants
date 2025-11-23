(define (make-my-hash-set)
  (define num-buckets 1000)
  (define buckets (build-vector num-buckets (lambda (i) '())))

  (define (add key)
    (define bucket-idx (modulo key num-buckets))
    (define current-list (vector-ref buckets bucket-idx))
    (unless (member key current-list)
      (vector-set! buckets bucket-idx (cons key current-list))))

  (define (remove key)
    (define bucket-idx (modulo key num-buckets))
    (define current-list (vector-ref buckets bucket-idx))
    (define new-list (filter (lambda (x) (not (= x key))) current-list))
    (vector-set! buckets bucket-idx new-list))

  (define (contains key)
    (define bucket-idx (modulo key num-buckets))
    (define current-list (vector-ref buckets bucket-idx))
    (not (not (member key current-list))))

  (hash 'add add
        'remove remove
        'contains contains))