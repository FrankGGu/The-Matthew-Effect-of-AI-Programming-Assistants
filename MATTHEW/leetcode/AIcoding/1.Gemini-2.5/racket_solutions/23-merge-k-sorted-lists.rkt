#lang racket

(define (heap-parent i) (floor (/ (- i 1) 2)))
(define (heap-left i) (+ (* 2 i) 1))
(define (heap-right i) (+ (* 2 i) 2))

(define (heap-swap! heap-vec i j)
  (let ((temp (vector-ref heap-vec i)))
    (vector-set! heap-vec i (vector-ref heap-vec j))
    (vector-set! heap-vec j temp)))

(define (heap-bubble-up! heap-vec i)
  (let loop ((current-i i))
    (let ((p (heap-parent current-i)))
      (when (and (> current-i 0)
                 (< (ListNode-val (vector-ref heap-vec current-i))
                    (ListNode-val (vector-ref heap-vec p))))
        (heap-swap! heap-vec current-i p)
        (loop p)))))

(define (heap-bubble-down! heap-vec i heap-size)
  (let loop ((current-i i))
    (let* ((l (heap-left current-i))
           (r (heap-right current-i))
           (smallest current-i))
      (when (and (< l heap-size)
                 (< (ListNode-val (vector-ref heap-vec l))
                    (ListNode-val (vector-ref heap-vec smallest))))
        (set! smallest l))
      (when (and (< r heap-size)
                 (< (ListNode-val (vector-ref heap-vec r))
                    (ListNode-val (vector-ref heap-vec smallest))))
        (set! smallest r))
      (when (not (= smallest current-i))
        (heap-swap! heap-vec current-i smallest)
        (loop smallest)))))

(define (make-min-heap max-size)
  (vector (make-vector max-size #f) 0))

(define (heap-push! heap-obj node)
  (let* ((heap-vec (vector-ref heap-obj 0))
         (heap-size (vector-ref heap-obj 1)))
    ;; In a real scenario, might need to resize the vector if full
    (when (>= heap-size (vector-length heap-vec))
      (error "Heap is full or initial size too small"))
    (vector-set! heap-vec heap-size node)
    (vector-set! heap-obj 1 (+ heap-size 1))
    (heap-bubble-up! heap-vec heap-size)))

(define (heap-pop! heap-obj)
  (let* ((heap-vec (vector-ref heap-obj 0))
         (heap-size (vector-ref heap-obj 1)))
    (when (zero? heap-size)
      (error "Heap is empty"))
    (let ((min-node (vector-ref heap-vec 0)))
      (vector-set! heap-vec 0 (vector-ref heap-vec (- heap-size 1)))
      (vector-set! heap-obj 1 (- heap-size 1))
      (when (> (- heap-size 1) 0)
        (heap-bubble-down! heap-vec 0 (- heap-size 1)))
      min-node)))

(define (heap-empty? heap-obj)
  (zero? (vector-ref heap-obj 1)))

(define (merge-k-lists lists)
  (let* ((k (length lists))
         (min-heap (make-min-heap (if (zero? k) 1 k)))) ; Heap size is k, stores at most k list heads

    ;; Populate heap with the head of each non-empty list
    (for-each (lambda (lst)
                (when (and lst (ListNode? lst)) ; Check if list is not #f/null
                  (heap-push! min-heap lst)))
              lists)

    ;; Recursively build the merged list
    (let loop ((result-head #f)
               (result-tail #f))
      (if (heap-empty? min-heap)
          result-head
          (let ((min-node (heap-pop! min-heap)))
            ;; Append min-node to the result list
            (if (not result-head)
                ;; First node of the result list
                (loop min-node min-node)
                ;; Subsequent nodes
                (begin
                  (set-ListNode-next! result-tail min-node) ; Mutate the tail's next pointer
                  (loop result-head min-node)))) ; Update result-tail
            ;; If the extracted node has a next, add it to the heap
            (when (ListNode-next min-node)
              (heap-push! min-heap (ListNode-next min-node)))))))