(define (two-out-of-three nums1 nums2 nums3)
  (define set1 (list->set nums1))
  (define set2 (list->set nums2))
  (define set3 (list->set nums3))

  (define (count-sets num)
    (+ (if (set-member? set1 num) 1 0)
       (if (set-member? set2 num) 1 0)
       (if (set-member? set3 num) 1 0)))

  (define all-nums (append nums1 nums2 nums3))
  (define unique-nums (remove-duplicates all-nums))

  (filter (lambda (num) (>= (count-sets num) 2)) unique-nums))