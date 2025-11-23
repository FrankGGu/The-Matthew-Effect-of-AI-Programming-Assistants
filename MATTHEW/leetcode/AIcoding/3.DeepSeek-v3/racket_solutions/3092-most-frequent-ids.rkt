(define (most-frequent-ids nums ks)
  (let loop ([nums nums]
             [ks ks]
             [freq (make-hash)]
             [max-freq 0]
             [max-ids '()]
             [result '()])
    (if (null? nums)
        (reverse result)
        (let* ([id (car nums)]
               [k (car ks)]
               [old-count (hash-ref freq id 0)]
               [new-count (+ old-count k)]
               [new-freq (if (zero? new-count)
                             (hash-remove freq id)
                             (hash-set freq id new-count))])
          (cond
            [(> new-count max-freq)
             (loop (cdr nums) (cdr ks) new-freq new-count (list id) (cons id result))]
            [(= new-count max-freq)
             (loop (cdr nums) (cdr ks) new-freq max-freq (cons id max-ids) (cons (apply max max-ids) result))]
            [else
             (loop (cdr nums) (cdr ks) new-freq max-freq max-ids (cons (if (null? max-ids) 0 (apply max max-ids)) result))])))))