(define (copy-random-list head)
  (if (null? head)
      null
      (begin
        ;; Step 1: Create new nodes and interweave them into the original list.
        ;; For each original node `curr`, insert its copy `copy-node` right after it.
        ;; Original: A -> B -> C
        ;; After Step 1: A -> A' -> B -> B' -> C -> C'
        (let loop-interweave ((curr head))
          (unless (null? curr)
            (let* ((next-node (Node-next curr))
                   (copy-node (Node (Node-val curr) next-node null))) ; random is null for now
              (set-Node-next! curr copy-node)
              (loop-interweave next-node))))

        ;; Step 2: Set the random pointers for the new nodes.
        ;; If original_node.random points to original_random_node,
        ;; then copy_node.random should point to copy_random_node.
        ;; Since copy_random_node is original_random_node.next, we can use that.
        (let loop-random ((curr head))
          (unless (null? curr)
            (let* ((copy-node (Node-next curr))
                   (random-node (Node-random curr)))
              (unless (null? random-node) ; If original node has a random pointer
                (set-Node-random! copy-node (Node-next random-node)))) ; copy_node.random = original_random_node.next
            (loop-random (Node-next (Node-next curr))))) ; Move to the next original node (curr -> copy -> next_original)

        ;; Step 3: Separate the original and copied lists.
        ;; Restore the original list's next pointers and form the new list's next pointers.
        (let* ((new-head (Node-next head)) ; The head of the new list is the copy of the original head
               (curr head))
          (let loop-separate ((orig-ptr curr) (copy-ptr new-head))
            (unless (null? orig-ptr)
              (set-Node-next! orig-ptr (Node-next copy-ptr)) ; Restore original list: orig_i.next = orig_{i+1}
              (when (Node-next orig-ptr) ; If there's an orig_{i+1}
                (set-Node-next! copy-ptr (Node-next (Node-next orig-ptr)))) ; Form new list: copy_i.next = copy_{i+1}
              (loop-separate (Node-next orig-ptr) (Node-next copy-ptr))))
          new-head))))