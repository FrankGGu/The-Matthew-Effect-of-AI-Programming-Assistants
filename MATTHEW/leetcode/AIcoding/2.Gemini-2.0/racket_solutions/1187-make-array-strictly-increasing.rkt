(define (make-array-strictly-increasing arr1 arr2)
  (define sorted-arr2 (sort (remove-duplicates arr2) <))

  (define memo (make-hash))

  (define (dp i prev)
    (let ((key (cons i prev)))
      (if (hash-has-key? memo key)
          (hash-ref memo key)
          (let ((res (cond
                       ((= i (length arr1)) 0)
                       ((> (list-ref arr1 i) prev)
                        (let ((no-swap (+ 1 (dp (+ i 1) (list-ref arr1 i)))))
                          (let ((can-swap? (and (not (null? sorted-arr2))
                                                 (> (car sorted-arr2) prev))))
                            (if can-swap?
                                (let ((next-greater (findf (lambda (x) (> x prev)) sorted-arr2)))
                                  (let ((index (index-of sorted-arr2 next-greater)))
                                    (let ((swap (+ 1 (dp (+ i 1) next-greater))))
                                      (min no-swap swap))))
                                no-swap))))
                       (else
                        (let ((can-swap? (and (not (null? sorted-arr2))
                                               (> (car sorted-arr2) prev))))
                          (if can-swap?
                              (let ((next-greater (findf (lambda (x) (> x prev)) sorted-arr2)))
                                (let ((index (index-of sorted-arr2 next-greater)))
                                  (let ((swap (+ 1 (dp (+ i 1) next-greater))))
                                    swap)))
                              #f))))))
            (if (equal? res #f)
                (begin (hash-set! memo key #f) #f)
                (begin (hash-set! memo key res) res)))))))

  (let ((result (dp 0 -1)))
    (if (equal? result #f) -1 result)))

(define (remove-duplicates lst)
  (let loop ((seen (set)) (lst lst) (result '()))
    (cond
      ((null? lst) (reverse result))
      (else
       (let ((head (car lst)) (tail (cdr lst)))
         (if (set-member? seen head)
             (loop seen tail result)
             (loop (set-add seen head) tail (cons head result))))))))

(define (index-of lst val)
  (let loop ((index 0) (lst lst))
    (cond
      ((null? lst) #f)
      ((equal? (car lst) val) index)
      (else (loop (+ index 1) (cdr lst))))))