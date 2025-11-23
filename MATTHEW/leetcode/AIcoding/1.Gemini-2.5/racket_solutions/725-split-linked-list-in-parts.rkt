(define-struct ListNode (val next))

(define (split-list-to-parts head k)
  ;; Helper to calculate the total length of the linked list
  (define (list-length node)
    (if (null? node)
        0
        (+ 1 (list-length (ListNode-next node)))))

  (define N (list-length head))
  (define base-size (quotient N k)) ; Base number of nodes for each part
  (define remainder (remainder N k)) ; Number of parts that will have an extra node

  ;; Recursive helper to build the list of parts
  ;; current-node: The head of the remaining list to be split
  ;; part-idx: The index of the current part being processed (from 0 to k-1)
  ;; result-list: An accumulator for the parts, built in reverse order
  (define (split-helper current-node part-idx result-list)
    (if (= part-idx k)
        ;; All k parts have been processed, reverse the accumulator and return
        (reverse result-list)
        (let* ((current-part-size (if (< part-idx remainder)
                                       (+ base-size 1) ; Parts with an extra node
                                       base-size))    ; Standard size parts
               (part-head current-node)) ; This will be the head of the current part
          (if (zero? current-part-size)
              ;; If the current part size is 0, add null to the result and move to the next part
              (split-helper current-node (+ part-idx 1) (cons null result-list))
              ;; Otherwise, traverse to find the end of the current part
              (let loop ((node current-node) (count 1))
                (if (= count current-part-size)
                    ;; We have reached the last node of the current part
                    (let* ((next-head (ListNode-next node))) ; Store the head of the next part
                      (set-ListNode-next! node null) ; Terminate the current part by setting its next to null
                      ;; Add the current part's head to the result list and recurse for the next part
                      (split-helper next-head (+ part-idx 1) (cons part-head result-list)))
                    ;; Not yet at the end of the current part, continue traversing
                    (loop (ListNode-next node) (+ count 1))))))))

  ;; Start the splitting process with the original head, first part index (0), and an empty result list
  (split-helper head 0 '()))