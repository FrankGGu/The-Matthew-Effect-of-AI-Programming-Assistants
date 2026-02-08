(struct ListNode (val next) #:mutable)

(define (add-two-numbers-ii l1 l2)
  (define s1 '()) ; Stack for digits of l1
  (define s2 '()) ; Stack for digits of l2

  ; Populate s1
  (let loop ((curr l1))
    (unless (false? curr)
      (set! s1 (cons (ListNode-val curr) s1))
      (loop (ListNode-next curr)))))

  ; Populate s2
  (let loop ((curr l2))
    (unless (false? curr)
      (set! s2 (cons (ListNode-val curr) s2))
      (loop (ListNode-next curr)))))

  (define carry 0)
  (define result-head #f) ; #f represents null

  ; Perform addition by popping from stacks
  (let loop ()
    (when (or (not (empty? s1)) (not (empty? s2)) (> carry 0))
      (define digit1 (if (empty? s1) 0 (car s1)))
      (define digit2 (if (empty? s2) 0 (car s2)))

      ; Pop from stacks
      (when (not (empty? s1)) (set! s1 (cdr s1)))
      (when (not (empty? s2)) (set! s2 (cdr s2)))

      (define sum (+ digit1 digit2 carry))
      (define new-digit (remainder sum 10))
      (set! carry (quotient sum 10))

      ; Prepend new node to the result list
      (define new-node (ListNode new-digit result-head))
      (set! result-head new-node)
      (loop)))
  result-head)