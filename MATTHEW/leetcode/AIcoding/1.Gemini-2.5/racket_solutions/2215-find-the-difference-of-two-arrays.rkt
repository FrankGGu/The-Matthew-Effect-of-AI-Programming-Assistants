(require racket/set)

(define (find-difference nums1 nums2)
  (let* ((set1 (list->set nums1))
         (set2 (list->set nums2))
         (diff1 (set->list (set-difference set1 set2)))
         (diff2 (set->list (set-difference set2 set1))))
    (list diff1 diff2)))