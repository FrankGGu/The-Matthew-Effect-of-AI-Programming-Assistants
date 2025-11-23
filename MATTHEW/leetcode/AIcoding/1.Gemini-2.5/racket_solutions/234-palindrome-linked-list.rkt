(struct ListNode (val next))

(define (is-palindrome head)
  (if (or (null? head) (null? (ListNode-next head)))
      #t
      (let loop ((current head) (vals '()))
        (if (null? current)
            (let* ((vec (list->vector (reverse vals)))
                   (len (vector-length vec)))
              (let compare-loop ((i 0) (j (- len 1)))
                (if (>= i j)
                    #t
                    (if (= (vector-ref vec i) (vector-ref vec j))
                        (compare-loop (+ i 1) (- j 1))
                        #f))))
            (loop (ListNode-next current) (cons (ListNode-val current) vals))))))