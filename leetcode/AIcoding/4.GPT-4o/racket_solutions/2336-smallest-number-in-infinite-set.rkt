(define smallestNumberInInfiniteSet
  (lambda ()
    (define seen (make-hash))
    (define available (let ([s (make-queue)]) (for ([i (in-range 1 (add1 (expt 10 6)))]) (enqueue! s i)) s))
    (define (pop) (if (queue-empty? available) (error "No numbers available") (dequeue! available)))
    (define (addBack num)
      (if (hash-ref seen num #f)
          (begin
            (hash-set! seen num #f)
            (enqueue! available num)))
      (hash-set! seen num #t))
    (define (getSmallest) (pop))
    (values getSmallest addBack)))