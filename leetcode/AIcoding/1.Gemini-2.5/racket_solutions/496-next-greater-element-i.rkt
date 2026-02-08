#lang racket

(define (next-greater-element-i nums1 nums2)
  (define next-greater-map (make-hash))
  (define stack '())

  (for-each (lambda (num)
              (let loop ()
                (when (and (not (empty? stack))
                           (> num (car stack)))
                  (hash-set! next-greater-map (car stack) num)
                  (set! stack (cdr stack))
                  (loop)))
              (set! stack (cons num stack)))
            nums2)

  (map (lambda (n1)
         (hash-ref next-greater-map n1 -1))
       nums1))