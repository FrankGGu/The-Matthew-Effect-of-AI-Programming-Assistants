(define (make-node val next)
  (list val next))

(define (get-value node)
  (car node))

(define (get-next node)
  (cadr node))

(define (insert-head head val)
  (make-node val head))

(define (length head)
  (if (not head)
      0
      (+ 1 (length (get-next head)))))

(define (get-at head index)
  (if (= index 0)
      (get-value head)
      (get-at (get-next head) (- index 1))))

(define (Solution. constructor head)
  (let ((size (length head)))
    (lambda (msg . args)
      (cond ((eq? msg 'getRandom)
             (let ((index (random size)))
               (get-at head index)))
            (else #f)))))