#lang racket

(struct skiplist-node (val next) #:mutable)

(struct Skiplist (head current-max-level) #:mutable)

(define MAX-LEVEL 16)

(define (make-node val level-height)
  (skiplist-node val (make-vector level-height #f)))

(define (random-level)
  (let loop ((level 1))
    (if (and (< level MAX-LEVEL)
             (zero? (random 2)))
        (loop (+ level 1))
        level)))

(define (skiplist-init)
  (Skiplist (make-node -1 MAX-LEVEL) 0))

(define (skiplist-search skiplist num)
  (let* ((head (Skiplist-head skiplist)))
    (let loop ((curr head) (level (- (Skiplist-current-max-level skiplist) 1)))
      (cond
        ((< level 0)
         (let ((next-node (vector-ref (skiplist-node-next curr) 0)))
           (and next-node (= (skiplist-node-val next-node) num))))
        (else
         (let loop-right ((c curr))
           (let ((next-node (vector-ref (skiplist-node-next c) level)))
             (cond
               ((and next-node (< (skiplist-node-val next-node) num))
                (loop-right next-node))
               (else
                (loop c (- level 1)))))))))))

(define (skiplist-add skiplist num)
  (let* ((head (Skiplist-head skiplist))
         (updates (make-vector MAX-LEVEL #f)))

    (let loop ((curr head) (level (- (Skiplist-current-max-level skiplist) 1)))
      (when (>= level 0)
        (let loop-right ((c curr))
          (let ((next-node (vector-ref (skiplist-node-next c) level)))
            (cond
              ((and next-node (< (skiplist-node-val next-node) num))
               (loop-right next-node))
              (else
               (vector-set! updates level c)
               (loop c (- level 1))))))))

    (let ((new-node-level (random-level)))
      (set-Skiplist-current-max-level! skiplist (max (Skiplist-current-max-level skiplist) new-node-level))

      (let ((new-node (make-node num new-node-level)))
        (for ((level (in-range new-node-level)))
          (let* ((node-to-update (vector-ref updates level))
                 (old-next (vector-ref (skiplist-node-next node-to-update) level)))
            (vector-set! (skiplist-node-next new-node) level old-next)
            (vector-set! (skiplist-node-next node-to-update) level new-node)))))))

(define (skiplist-erase skiplist num)
  (let* ((head (Skiplist-head skiplist))
         (updates (make-vector MAX-LEVEL #f))
         (found-target #f))

    (let loop ((curr head) (level (- (Skiplist-current-max-level skiplist) 1)))
      (when (>= level 0)
        (let loop-right ((c curr))
          (let ((next-node (vector-ref (skiplist-node-next c) level)))
            (cond
              ((and next-node (< (skiplist-node-val next-node) num))
               (loop-right next-node))
              (else
               (vector-set! updates level c)
               (loop c (- level 1))))))))

    (let ((node-at-level0 (vector-ref (skiplist-node-next (vector-ref updates 0)) 0)))
      (when (and node-at-level0 (= (skiplist-node-val node-at-level0) num))
        (set! found-target #t)
        (for ((level (in-range (Skiplist-current-max-level skiplist))))
          (let ((node-to-update (vector-ref updates level)))
            (when (and node-to-update
                       (let ((next-of-update (vector-ref (skiplist-node-next node-to-update) level)))
                         (and next-of-update (= (skiplist-node-val next-of-update) num))))
              (vector-set! (skiplist-node-next node-to-update) level (vector-ref (skiplist-node-next node-at-level0) level)))))))

    (when found-target
      (let loop-adjust ((level (- (Skiplist-current-max-level skiplist) 1)))
        (when (and (>= level 0)
                   (not (vector-ref (skiplist-node-next head) level)))
          (set-Skiplist-current-max-level! skiplist level)
          (loop-adjust (- level 1)))))

    found-target))