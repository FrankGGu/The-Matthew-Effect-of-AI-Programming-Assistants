(require racket/set)

(define (two-out-of-three nums1 nums2 nums3)
  (define s1 (list->set nums1))
  (define s2 (list->set nums2))
  (define s3 (list->set nums3))

  (define common12 (set-intersect s1 s2))
  (define common13 (set-intersect s1 s3))
  (define common23 (set-intersect s2 s3))

  (set->list (set-union common12 common13 common23)))