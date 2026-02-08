(define (invertSubtree root)
  (if (null? root)
      '()
      (let ((temp (car root)))
        (set-car! root (cadr root))
        (set-cadr! root temp)
        (append (invertSubtree (car root)) (invertSubtree (cadr root))))))

(define (subtreeInversionSum tree)
  (if (null? tree)
      0
      (+ (invertSubtree tree)
         (subtreeInversionSum (car tree))
         (subtreeInversionSum (cadr tree)))))

(define (invertAndSum root)
  (subtreeInversionSum root))