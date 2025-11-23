(define (max-product root)
  (define (total-sum node)
    (if (null? node)
        0
        (+ (car node) (total-sum (cadr node)) (total-sum (caddr node)))))

  (define total (total-sum root))

  (define (subtree-sum node)
    (if (null? node)
        0
        (+ (car node) (subtree-sum (cadr node)) (subtree-sum (caddr node)))))

  (define (max-product-helper node)
    (if (null? node)
        0
        (let* ([left-sum (subtree-sum (cadr node))]
               [right-sum (subtree-sum (caddr node))]
               [current-product (max (* left-sum (- total left-sum)) (* right-sum (- total right-sum)))]
               [left-max (max-product-helper (cadr node))]
               [right-max (max-product-helper (caddr node))])
          (max current-product left-max right-max))))

  (modulo (max-product-helper root) 1000000007))