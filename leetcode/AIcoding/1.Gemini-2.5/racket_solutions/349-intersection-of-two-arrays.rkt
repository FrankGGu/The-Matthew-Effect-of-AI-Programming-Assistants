#lang racket

(require racket/set)

(define (intersection nums1 nums2)
  (let* ([set1 (list->set nums1)]
         [result-set (set)])
    (for-each (lambda (num)
                (when (set-member? set1 num)
                  (set-add! result-set num)))
              nums2)
    (set->list result-set)))