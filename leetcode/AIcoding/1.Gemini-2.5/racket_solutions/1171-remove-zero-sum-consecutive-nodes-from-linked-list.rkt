#lang racket

(struct ListNode (val next) #:mutable)

(define (remove-zero-sum-sublists head)
  (define dummy (ListNode 0 head))
  (define prefix-sums (make-hash)) ; Maps sum -> ListNode
  (hash-set! prefix-sums 0 dummy)

  (define current-sum 0)
  (define current-node dummy)

  (while (ListNode-next current-node)
    (set! current-node (ListNode-next current-node))
    (set! current-sum (+ current-sum (ListNode-val current-node)))

    (if (hash-has-key? prefix-sums current-sum)
        ; Zero-sum sequence found
        (begin
          (define node-to-link-from (hash-ref prefix-sums current-sum))

          ; Remove intermediate sums from hash table
          ; The `temp-sum-to-remove` variable will store prefix sums for nodes
          ; between `node-to-link-from` and `current-node` (exclusive of `node-to-link-from`,
          ; inclusive of `current-node`'s sum if it was added to the map).
          ; We start `temp-sum-to-remove` with the prefix sum at `node-to-link-from`,
          ; which is `current-sum` in this context.
          (define temp-node (ListNode-next node-to-link-from))
          (define temp-sum-to-remove current-sum)

          (while (not (eq? temp-node current-node))
            (set! temp-sum-to-remove (+ temp-sum-to-remove (ListNode-val temp-node)))
            (hash-remove! prefix-sums temp-sum-to-remove)
            (set! temp-node (ListNode-next temp-node)))

          ; Relink the list to bypass the zero-sum sequence
          (set-ListNode-next! node-to-link-from (ListNode-next current-node))

          ; Reset `current-node` to `node-to-link-from`.
          ; The `current-sum` variable already holds the correct prefix sum
          ; (the sum up to `node-to-link-from`), so it doesn't need to be explicitly reset.
          ; The loop will then advance `current-node` to `node-to-link-from`'s
          ; new `next` in the next iteration.
          (set! current-node node-to-link-from))
        ; No zero-sum sequence ending at current-node, so add current prefix sum to hash table
        (begin
          (hash-set! prefix-sums current-sum current-node))))

  (ListNode-next dummy))