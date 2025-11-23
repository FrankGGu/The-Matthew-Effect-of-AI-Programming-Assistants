#lang racket

(define (reverse-list head)
  (let loop ((current head)
             (prev null))
    (if (null? current)
        prev
        (let ((next-node (ListNode-next current)))
          (set-ListNode-next! current prev)
          (loop next-node current)))))

(define (find-middle-and-split head)
  (let loop ((slow head)
             (fast head)
             (prev-slow null)) ; Pointer to the node before slow
    (cond
      ((or (null? fast) (null? (ListNode-next fast)))
       ;; Fast pointer reached the end.
       ;; Slow pointer is at the start of the second half (or middle for odd length).
       ;; prev-slow is the end of the first half.
       (values head prev-slow slow))
      (else
       (loop (ListNode-next slow)
             (ListNode-next (ListNode-next fast))
             slow))))))

(define (palindrome? head)
  ;; Base cases: 0 or 1 node lists are always palindromes.
  (when (or (null? head) (null? (ListNode-next head)))
    #t)

  ;; 1. Find the middle of the list and get the split points.
  (let-values (((first-half-head first-half-end second-half-start))
               (find-middle-and-split head)))

  ;; 2. Disconnect the first half from the second half.
  ;; This is only necessary if first-half-end is not null (i.e., list has more than 1 node).
  (unless (null? first-half-end)
    (set-ListNode-next! first-half-end null))

  ;; 3. Reverse the second half of the list.
  (let* ((reversed-second-half (reverse-list second-half-start))
         (p1 first-half-head)
         (p2 reversed-second-half)
         (is-pal #t))

    ;; 4. Compare the first half with the reversed second half.
    (let loop ((curr1 p1)
               (curr2 p2))
      (when (and curr1 curr2)
        (unless (= (ListNode-val curr1) (ListNode-val curr2))
          (set! is-pal #f))
        (loop (ListNode-next curr1)
              (ListNode-next curr2))))

    ;; 5. Restore the list to its original state (optional, but good practice for O(1) space solutions).
    (let ((restored-second-half (reverse-list reversed-second-half)))
      (unless (null? first-half-end)
        (set-ListNode-next! first-half-end restored-second-half)))

    ;; 6. Return the result of the comparison.
    is-pal))