#lang racket

(require data/queue)
(require racket/control) ; For let/ec to enable early exit

(define (sequence-reconstruction org seqs)
  (let/ec return
    (define n (length org))

    ;; Handle empty org case
    (when (= n 0)
      (for ([s seqs])
        (when (not (empty? s))
          (return #f))) ; If org is empty, seqs must also be empty or contain only empty lists
      (return #t))

    ;; Initialize graph structures
    (define adj (make-hash))       ; Adjacency list: node -> list of neighbors
    (define in-degree (make-hash)) ; In-degree: node -> count
    (define seen-nums (make-hash)) ; To track all unique numbers from org that appear in seqs

    ;; Initialize in-degrees and adj lists for all numbers from 1 to n
    (for ([i (range 1 (+ n 1))])
      (hash-set! in-degree i 0)
      (hash-set! adj i '()))

    ;; Build graph and update in-degrees
    (for ([s seqs])
      (when (not (empty? s))
        (define prev (car s))

        ;; Validate first element of sequence: must be within [1, n]
        (when (or (< prev 1) (> prev n))
          (return #f))
        (hash-set! seen-nums prev #t)

        (for ([curr (cdr s)])
          ;; Validate current element of sequence: must be within [1, n]
          (when (or (< curr 1) (> curr n))
            (return #f))
          (hash-set! seen-nums curr #t)

          ;; Add edge if not already present to avoid duplicate edges and incorrect in-degree counts
          (unless (member curr (hash-ref adj prev))
            (hash-set! adj prev (cons curr (hash-ref adj prev)))
            (hash-set! in-degree curr (+ 1 (hash-ref in-degree curr))))
          (set! prev curr))))

    ;; Check if all numbers from org were seen in seqs.
    ;; If some numbers from org are missing from all seqs,
    ;; it's impossible to uniquely reconstruct org.
    (unless (= (hash-count seen-nums) n)
      (return #f))

    ;; Initialize queue with nodes having an in-degree of 0
    (define q (make-queue))
    (for ([i (range 1 (+ n 1))])
      (when (= (hash-ref in-degree i) 0)
        (enqueue! q i)))

    ;; Perform topological sort
    (define reconstructed-seq-rev '()) ; Build in reverse order for O(1) cons
    (while (not (queue-empty? q))
      ;; If more than one element in the queue, reconstruction is not unique
      (when (> (queue-count q) 1)
        (return #f))

      (define u (dequeue! q))
      (set! reconstructed-seq-rev (cons u reconstructed-seq-rev))

      ;; Decrement in-degree of neighbors and enqueue if their in-degree becomes 0
      (for ([v (hash-ref adj u)])
        (hash-set! in-degree v (- (hash-ref in-degree v) 1))
        (when (= (hash-ref in-degree v) 0)
          (enqueue! q v))))

    ;; After topological sort, if the length of the reconstructed sequence is not n,
    ;; it means there was a cycle or some nodes were unreachable,
    ;; implying an invalid reconstruction.
    (unless (= (length reconstructed-seq-rev) n)
      (return #f))

    ;; Final check: if the reconstructed sequence matches org
    (equal? (reverse reconstructed-seq-rev) org)))