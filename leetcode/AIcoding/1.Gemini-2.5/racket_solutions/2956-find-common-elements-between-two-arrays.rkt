(require racket/set)
(require racket/list)

(define (find-common-elements nums1 nums2)
  (let* ([set1 (list->set nums1)]
         [set2 (list->set nums2)]
         [count1 (for/sum ([x (in-list nums1)])
                   (if (set-member? set2 x) 1 0))]
         [count2 (for/sum ([x (in-list nums2)])
                   (if (set-member? set1 x) 1 0))])
    (list count1 count2)))