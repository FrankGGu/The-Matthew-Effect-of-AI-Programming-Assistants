#lang racket

(provide (struct-out ListNode) num-components)

(struct ListNode (val next))

(define (num-components head nums)
  (define nums-set (make-hash))
  (for-each (lambda (n) (hash-set! nums-set n #t)) nums)

  (define count 0)
  (define in-component? #f)
  (define current head)

  (let loop ()
    (when current
      (let ((val (ListNode-val current)))
        (if (hash-has-key? nums-set val)
            (unless in-component?
              (set! count (+ count 1))
              (set! in-component? #t))
            (set! in-component? #f)))
      (set! current (ListNode-next current))
      (loop)))
  count)