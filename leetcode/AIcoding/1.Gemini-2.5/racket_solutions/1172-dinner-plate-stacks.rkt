#lang racket
(require racket/set)

(struct dinner-plates (capacity stacks available-push-indices non-empty-pop-indices)
  #:mutable)

(define (make-dinner-plates capacity)
  (dinner-plates capacity (make-vector 0) (set) (set)))

(define (get-or-create-stack-info! dp stack-idx)
  (let* ([current-stacks (dinner-plates-stacks dp)]
         [current-len (vector-length current-stacks)])
    (when (>= stack-idx current-len)
      (let ([new-len (+ stack-idx 1)])
        (let ([new-stacks (make-vector new-len #f)])
          (for ([i (in-range current-len)])
            (vector-set! new-stacks i (vector-ref current-stacks i)))
          (set-dinner-plates-stacks! dp new-stacks))))
    (let ([stack-info (vector-ref (dinner-plates-stacks dp) stack-idx)])
      (if (eq? stack-info #f)
          (begin
            (vector-set! (dinner-plates-stacks dp) stack-idx (cons '() 0))
            (vector-ref (dinner-plates-stacks dp) stack-idx))
          stack-info))))

(define (dinner-plates-push! dp val)
  (let ([cap (dinner-plates-capacity dp)])
    (let loop ([available-indices (dinner-plates-available-push-indices dp)])
      (let ([stack-idx (if (set-empty? available-indices)
                           (vector-length (dinner-plates-stacks dp))
                           (set-first available-indices))])

        (let* ([stack-info (get-or-create-stack-info! dp stack-idx)]
               [current-stack-list (car stack-info)]
               [current-size (cdr stack-info)])

          (if (= current-size cap)
              (loop (set-remove available-indices stack-idx))

              (let* ([new-stack-list (cons val current-stack-list)]
                     [new-size (+ current-size 1)])
                (vector-set! (dinner-plates-stacks dp) stack-idx (cons new-stack-list new-size))

                (set-dinner-plates-available-push-indices! dp
                                                          (if (= new-size cap)
                                                              (set-remove available-indices stack-idx)
                                                              available-indices))

                (set-dinner-plates-non-empty-pop-indices! dp
                                                          (set-add (dinner-plates-non-empty-pop-indices dp) stack-idx)))))))))

(define (dinner-plates-pop! dp)
  (let loop ([non-empty-indices (dinner-plates-non-empty-pop-indices dp)])
    (if (set-empty? non-empty-indices)
        -1
        (let* ([stack-idx (set-last non-empty-indices)]
               [stack-info (get-or-create-stack-info! dp stack-idx)]
               [current-stack-list (car stack-info)]
               [current-size (cdr stack-info)])

          (if (zero? current-size)
              (loop (set-remove non-empty-indices stack-idx))

              (let* ([popped-val (car current-stack-list)]
                     [new-stack-list (cdr current-stack-list)]
                     [new-size (- current-size 1)])
                (vector-set! (dinner-plates-stacks dp) stack-idx (cons new-stack-list new-size))

                (set-dinner-plates-available-push-indices! dp
                                                          (set-add (dinner-plates-available-push-indices dp) stack-idx))

                (set-dinner-plates-non-empty-pop-indices! dp
                                                          (if (zero? new-size)
                                                              (set-remove non-empty-indices stack-idx)
                                                              non-empty-indices))
                popped-val))))))

(define (dinner-plates-pop-at-stack! dp index)
  (let* ([stacks-vec (dinner-plates-stacks dp)]
         [vec-len (vector-length stacks-vec)])

    (if (or (< index 0) (>= index vec-len))
        -1
        (let* ([stack-info (vector-ref stacks-vec index)])
          (if (eq? stack-info #f)
              -1
              (let* ([current-stack-list (car stack-info)]
                     [current-size (cdr stack-info)])
                (if (zero? current-size)
                    -1
                    (let* ([popped-val (car current-stack-list)]
                           [new-stack-list (cdr current-stack-list)]
                           [new-size (- current-size 1)])
                      (vector-set! stacks-vec index (cons new-stack-list new-size))

                      (set-dinner-plates-available-push-indices! dp
                                                                (set-add (dinner-plates-available-push-indices dp) index))

                      (when (zero? new-size)
                        (set-dinner-plates-non-empty-pop-indices! dp
                                                                  (set-remove (dinner-plates-non-empty-pop-indices dp) index)))
                      popped-val))))))))