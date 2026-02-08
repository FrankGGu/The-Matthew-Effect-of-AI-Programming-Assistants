(struct node (val next) #:mutable #:transparent)

(define (make-node val next) (node val next))

(define my-linked-list%
  (class object%
    (super-new)

    (init-field)
    (field [head null])
    (field [size 0])

    (define/public (get-node index)
      (if (or (< index 0) (>= index size))
          null
          (let loop ([i 0] [curr head])
            (if (= i index)
                curr
                (loop (add1 i) (node-next curr))))))

    (define/public (get index)
      (let ([node (get-node index)])
        (if (null? node)
            -1
            (node-val node))))

    (define/public (add-at-head val)
      (set! head (make-node val head))
      (set! size (add1 size)))

    (define/public (add-at-tail val)
      (if (null? head)
          (add-at-head val)
          (let loop ([curr head])
            (if (null? (node-next curr))
                (begin
                  (set-node-next! curr (make-node val null))
                  (set! size (add1 size)))
                (loop (node-next curr))))))

    (define/public (add-at-index index val)
      (cond
        [(> index size) (void)]
        [(= index 0) (add-at-head val)]
        [(= index size) (add-at-tail val)]
        [else
         (let ([prev (get-node (sub1 index))])
           (unless (null? prev)
             (let ([new-node (make-node val (node-next prev))])
               (set-node-next! prev new-node)
               (set! size (add1 size)))))]))

    (define/public (delete-at-index index)
      (when (and (>= index 0) (< index size))
        (if (= index 0)
            (begin
              (set! head (node-next head))
              (set! size (sub1 size)))
            (let ([prev (get-node (sub1 index))])
              (unless (null? prev)
                (set-node-next! prev (node-next (node-next prev)))
                (set! size (sub1 size))))))))