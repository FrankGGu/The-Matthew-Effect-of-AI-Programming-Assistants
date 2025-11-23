(define struct ListNode (val next))

(define (isPalindrome head)
  (define (reverse lst)
    (let loop ((current lst) (prev #f))
      (if (null? current)
          prev
          (loop (ListNode-next current) (ListNode (ListNode-val current) prev)))))

  (define (find-middle slow fast)
    (if (null? fast)
        slow
        (find-middle (ListNode-next slow) (ListNode-next (ListNode-next fast)))))

  (if (or (null? head) (null? (ListNode-next head)))
      #t
      (let* ((mid (find-middle head head))
             (second-half (reverse mid)))
        (let loop ((first head) (second second-half))
          (if (null? second)
              #t
              (and (= (ListNode-val first) (ListNode-val second))
                   (loop (ListNode-next first) (ListNode-next second)))))))))