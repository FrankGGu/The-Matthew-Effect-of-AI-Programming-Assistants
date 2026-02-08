(define/contract (min-stone-sum piles k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([heap (make-heap (lambda (a b) (> a b)))]
             [piles piles]
             [k k])
    (if (null? piles)
        (if (zero? k)
            (heap-sum heap)
            (let* ([max-val (heap-max heap)]
                   [new-val (ceiling (/ max-val 2))])
              (begin
                (heap-remove-max! heap)
                (heap-add! heap new-val)
                (loop heap '() (sub1 k)))))
        (begin
          (heap-add! heap (car piles))
          (loop heap (cdr piles) k)))))

(define (heap-sum heap)
  (let loop ([sum 0])
    (if (heap-empty? heap)
        sum
        (loop (+ sum (heap-remove-max! heap))))))

(define (make-heap cmp)
  (let ([vec (make-vector 1 #f)]
        [size 0])
    (lambda (msg . args)
      (case msg
        [(add!) 
         (let ([val (car args)])
           (set! size (add1 size))
           (when (>= size (vector-length vec))
             (let ([new-vec (make-vector (* 2 (vector-length vec)) #f)])
               (vector-copy! new-vec 0 vec)
               (set! vec new-vec)))
           (vector-set! vec size val)
          (let bubble-up ([i size])
            (let ([parent (quotient i 2)])
              (when (and (> i 1) (cmp (vector-ref vec i) (vector-ref vec parent)))
                (let ([tmp (vector-ref vec parent)])
                  (vector-set! vec parent (vector-ref vec i))
                  (vector-set! vec i tmp))
                (bubble-up parent)))))]
        [(remove-max!)
         (let ([max-val (vector-ref vec 1)])
           (vector-set! vec 1 (vector-ref vec size))
           (set! size (sub1 size))
           (let bubble-down ([i 1])
             (let* ([left (* 2 i)]
                    [right (add1 left)]
                    [largest (if (and (<= left size) (cmp (vector-ref vec left) (vector-ref vec i)))
                                 left
                                 i)])
               (set! largest (if (and (<= right size) (cmp (vector-ref vec right) (vector-ref vec largest)))
                                 right
                                 largest))
               (when (not (= largest i))
                 (let ([tmp (vector-ref vec i)])
                   (vector-set! vec i (vector-ref vec largest))
                   (vector-set! vec largest tmp))
                 (bubble-down largest))))
           max-val)]
        [(max) (vector-ref vec 1)]
        [(empty?) (zero? size)]
        [else (error "Unknown heap operation")]))))