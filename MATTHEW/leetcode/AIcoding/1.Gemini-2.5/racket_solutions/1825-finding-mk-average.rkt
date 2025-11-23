#lang racket

(require data/red-black-tree)
(require racket/queue)

(struct mk-avg (m k
                q ; queue of (num . id) pairs, oldest first
                left-k-tree left-k-sum left-k-count
                middle-tree middle-sum middle-count
                right-k-tree right-k-sum right-k-count
                next-id)
  #:mutable)

(define (compare-pairs a b)
  (let ((num-a (car a)) (id-a (cdr a))
        (num-b (car b)) (id-b (cdr b)))
    (cond
      ((< num-a num-b) -1)
      ((> num-a num-b) 1)
      ((< id-a id-b) -1)
      ((> id-a id-b) 1)
      (else 0))))

(define (mk-average-init m k)
  (mk-avg m k
          (make-queue)
          (rbt) 0 0
          (rbt) 0 0
          (rbt) 0 0
          0))

(define (remove-from-tree! tree-getter tree-setter sum-getter sum-setter count-getter count-setter val obj)
  (tree-setter obj (rbt-remove (tree-getter obj) val compare-pairs))
  (sum-setter obj (- (sum-getter obj) (car val)))
  (count-setter obj (- (count-getter obj) 1)))

(define (add-to-tree! tree-getter tree-setter sum-getter sum-setter count-getter count-setter val obj)
  (tree-setter obj (rbt-insert (tree-getter obj) val val compare-pairs))
  (sum-setter obj (+ (sum-getter obj) (car val)))
  (count-setter obj (+ (count-getter obj) 1)))

(define (move-min! src-tree-getter src-tree-setter src-sum-getter src-sum-setter src-count-getter src-count-setter
                   dest-tree-getter dest-tree-setter dest-sum-getter dest-sum-setter dest-count-getter dest-count-setter
                   obj)
  (let* ((min-val (rbt-min-key (src-tree-getter obj))))
    (remove-from-tree! src-tree-getter src-tree-setter src-sum-getter src-sum-setter src-count-getter src-count-setter min-val obj)
    (add-to-tree! dest-tree-getter dest-tree-setter dest-sum-getter dest-sum-setter dest-count-getter dest-count-setter min-val obj)))

(define (move-max! src-tree-getter src-tree-setter src-sum-getter src-sum-setter src-count-getter src-count-setter
                   dest-tree-getter dest-tree-setter dest-sum-getter dest-sum-setter dest-count-getter dest-count-setter
                   obj)
  (let* ((max-val (rbt-max-key (src-tree-getter obj))))
    (remove-from-tree! src-tree-getter src-tree-setter src-sum-getter src-sum-setter src-count-getter src-count-setter max-val obj)
    (add-to-tree! dest-tree-getter dest-tree-setter dest-sum-getter dest-sum-setter dest-count-getter dest-count-setter max-val obj)))

(define (_rebalance obj)
  (let ((k (mk-avg-k obj)))
    (let loop ()
      (let ((changed #f))
        ; Step 1: Ensure left_k has at most k elements
        (when (> (mk-avg-left-k-count obj) k)
          (move-max! mk-avg-left-k-tree set-mk-avg-left-k-tree! mk-avg-left-k-sum set-mk-avg-left-k-sum! mk-avg-left-k-count set-mk-avg-left-k-count!
                     mk-avg-middle-tree set-mk-avg-middle-tree! mk-avg-middle-sum set-mk-avg-middle-sum! mk-avg-middle-count set-mk-avg-middle-count!
                     obj)
          (set! changed #t))

        ; Step 2: Ensure right_k has at most k elements
        (when (> (mk-avg-right-k-count obj) k)
          (move-min! mk-avg-right-k-tree set-mk-avg-right-k-tree! mk-avg-right-k-sum set-mk-avg-right-k-sum! mk-avg-right-k-count set-mk-avg-right-k-count!
                     mk-avg-middle-tree set-mk-avg-middle-tree! mk-avg-middle-sum set-mk-avg-middle-sum! mk-avg-middle-count set-mk-avg-middle-count!
                     obj)
          (set! changed #t))

        ; Step 3: Ensure left_k has k elements (if middle has elements)
        (when (and (< (mk-avg-left-k-count obj) k) (> (mk-avg-middle-count obj) 0))
          (move-min! mk-avg-middle-tree set-mk-avg-middle-tree! mk-avg-middle-sum set-mk-avg-middle-sum! mk-avg-middle-count set-mk-avg-middle-count!
                     mk-avg-left-k-tree set-mk-avg-left-k-tree! mk-avg-left-k-sum set-mk-avg-left-k-sum! mk-avg-left-k-count set-mk-avg-left-k-count!
                     obj)
          (set! changed #t))

        ; Step 4: Ensure right_k has k elements (if middle has elements)
        (when (and (< (mk-avg-right-k-count obj) k) (> (mk-avg-middle-count obj) 0))
          (move-max! mk-avg-middle-tree set-mk-avg-middle-tree! mk-avg-middle-sum set-mk-avg-middle-sum! mk-avg-middle-count set-mk-avg-middle-count!
                     mk-avg-right-k-tree set-mk-avg-right-k-tree! mk-avg-right-k-sum set-mk-avg-right-k-sum! mk-avg-right-k-count set-mk-avg-right-k-count!
                     obj)
          (set! changed #t))

        ; Step 5: Ensure order: max(left_k) <= min(middle)
        (when (and (> (mk-avg-left-k-count obj) 0)
                   (> (mk-avg-middle-count obj) 0)
                   (> (car (rbt-max-key (mk-avg-left-k-tree obj))) (car (rbt-min-key (mk-avg-middle-tree obj)))))
          (move-max! mk-avg-left-k-tree set-mk-avg-left-k-tree! mk-avg-left-k-sum set-mk-avg-left-k-sum! mk-avg-left-k-count set-mk-avg-left-k-count!
                     mk-avg-middle-tree set-mk-avg-middle-tree! mk-avg-middle-sum set-mk-avg-middle-sum! mk-avg-middle-count set-mk-avg-middle-count!
                     obj)
          (move-min! mk-avg-middle-tree set-mk-avg-middle-tree! mk-avg-middle-sum set-mk-avg-middle-sum! mk-avg-middle-count set-mk-avg-middle-count!
                     mk-avg-left-k-tree set-mk-avg-left-k-tree! mk-avg-left-k-sum set-mk-avg-left-k-sum! mk-avg-left-k-count set-mk-avg-left-k-count!
                     obj)
          (set! changed #t))

        ; Step 6: Ensure order: max(middle) <= min(right_k)
        (when (and (> (mk-avg-middle-count obj) 0)
                   (> (mk-avg-right-k-count obj) 0)
                   (> (car (rbt-max-key (mk-avg-middle-tree obj))) (car (rbt-min-key (mk-avg-right-k-tree obj)))))
          (move-max! mk-avg-middle-tree set-mk-avg-middle-tree! mk-avg-middle-sum set-mk-avg-middle-sum! mk-avg-middle-count set-mk-avg-middle-count!
                     mk-avg-right-k-tree set-mk-avg-right-k-tree! mk-avg-right-k-sum set-mk-avg-right-k-sum! mk-avg-right-k-count set-mk-avg-right-k-count!
                     obj)
          (move-min! mk-avg-right-k-tree set-mk-avg-right-k-tree! mk-avg-right-k-sum set-mk-avg-right-k-sum! mk-avg-right-k-count set-mk-avg-right-k-count!
                     mk-avg-middle-tree set-mk-avg-middle-tree! mk-avg-middle-sum set-mk-avg-middle-sum! mk-avg-middle-count set-mk-avg-middle-count!
                     obj)
          (set! changed #t))

        (when changed (loop))))))

(define (mk-average-add-element obj num)
  (let* ((m (mk-avg-m obj))
         (val (cons num (mk-avg-next-id obj))))
    (set-mk-avg-next-id! obj (+ (mk-avg-next-id obj) 1))

    (enqueue! (mk-avg-q obj) val)

    (add-to-tree! mk-avg-middle-tree set-mk-avg-middle-tree! mk-avg-middle-sum set-mk-avg-middle-sum! mk-avg-middle-count set-mk-avg-middle-count! val obj)

    (_rebalance obj)

    (when (> (queue-count (mk-avg-q obj)) m)
      (let* ((oldest-val (dequeue! (mk-avg-q obj))))
        (cond
          ((rbt-contains? (mk-avg-left-k-tree obj) oldest-val compare-pairs)
           (remove-from-tree! mk-avg-left-k-tree set-mk-avg-left-k-tree! mk-avg-left-k-sum set-mk-avg-left-k-sum! mk-avg-left-k-count set-mk-avg-left-k-count! oldest-val obj))
          ((rbt-contains? (mk-avg-middle-tree obj) oldest-val compare-pairs)
           (remove-from-tree! mk-avg-middle-tree set-mk-avg-middle-tree! mk-avg-middle-sum set-mk-avg-middle-sum! mk-avg-middle-count set-mk-avg-middle-count! oldest-val obj))
          ((rbt-contains? (mk-avg-right-k-tree obj) oldest-val compare-pairs)
           (remove-from-tree! mk-avg-right-k-tree set-mk-avg-right-k-tree! mk-avg-right-k-sum set-mk-avg-right-k-sum! mk-avg-right-k-count set-mk-avg-right-k-count! oldest-val obj))
          (else
           (error "Element not found in any tree during removal"))
          )
        (_rebalance obj)))))

(define (mk-average-calculate obj)
  (let ((m (mk-avg-m obj)))
    (if (< (queue-count (mk-avg-q obj)) m)
        -1
        (floor (/ (mk-avg-middle-sum obj) (mk-avg-middle-count obj))))))