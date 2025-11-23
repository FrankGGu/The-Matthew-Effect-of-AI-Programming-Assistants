(define (solve inventory orders)
  (define (update-inventory inv ord)
    (let ((item (car ord))
          (quantity (cadr ord)))
      (let ((idx (index inv item)))
        (if idx
            (let ((current-quantity (cadr (list-ref inv idx))))
              (if (>= current-quantity quantity)
                  (list-set inv idx (list item (- current-quantity quantity)))
                  (error "Not enough stock")))
            (error "Item not found")))))

  (define (index lst item)
    (let loop ((i 0) (xs lst))
      (cond
        ((null? xs) #f)
        ((equal? item (car (car xs))) i)
        (else (loop (+ i 1) (cdr xs))))))

  (let loop ((remaining-orders orders) (current-inventory inventory))
    (cond
      ((null? remaining-orders) current-inventory)
      (else
       (loop (cdr remaining-orders) (update-inventory current-inventory (car remaining-orders)))))))