(define-struct min-stack (main-stack min-stack))

(define (MinStack)
  (make-min-stack (box '()) (box '())))

(define (MinStack-push this x)
  (let* ((current-main (unbox (min-stack-main-stack this)))
         (current-min (unbox (min-stack-min-stack this))))
    (set-box! (min-stack-main-stack this) (cons x current-main))
    (when (or (empty? current-min) (<= x (car current-min)))
      (set-box! (min-stack-min-stack this) (cons x current-min)))))

(define (MinStack-pop this)
  (let* ((current-main (unbox (min-stack-main-stack this)))
         (current-min (unbox (min-stack-min-stack this)))
         (popped-val (car current-main)))
    (set-box! (min-stack-main-stack this) (cdr current-main))
    (when (= popped-val (car current-min))
      (set-box! (min-stack-min-stack this) (cdr current-min)))))

(define (MinStack-top this)
  (car (unbox (min-stack-main-stack this))))

(define (MinStack-getMin this)
  (car (unbox (min-stack-min-stack this))))