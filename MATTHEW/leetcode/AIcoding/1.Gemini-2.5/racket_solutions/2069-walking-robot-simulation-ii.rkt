(define-struct robot (w h current-d))

(define (robot-init width height)
  (make-robot width height 0))

(define (robot-step this num)
  (set-robot-current-d! this (+ (robot-current-d this) num)))

(define (robot-get-pos-dir this)
  (let* ((w (robot-w this))
         (h (robot-h this))
         (d (robot-current-d this)))
    (let* ((w-minus-1 (- w 1))
           (h-minus-1 (- h 1))
           (seg1-len w-minus-1)
           (seg2-len h-minus-1)
           (seg3-len w-minus-1)
           (seg4-len h-minus-1)
           (P (+ seg1-len seg2-len seg3-len seg4-len)))
      (cond
        ((and (= w 1) (= h 1)) (list 0 0 "East"))
        (else
         (let ((d-mod-P (modulo d P)))
           (cond
             ((= d-mod-P 0) (list 0 0 "East"))
             ((<= d-mod-P seg1-len) (list d-mod-P 0 "East"))
             ((<= d-mod-P (+ seg1-len seg2-len)) (list w-minus-1 (- d-mod-P seg1-len) "North"))
             ((<= d-mod-P (+ seg1-len seg2-len seg3-len)) (list (- w-minus-1 (- d-mod-P (+ seg1-len seg2-len))) h-minus-1 "West"))
             (else (list 0 (- h-minus-1 (- d-mod-P (+ seg1-len seg2-len seg3-len))) "South")))))))))