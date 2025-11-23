(define (maxNumber nums1 nums2 k)
  (define (merge vec1 vec2)
    (let loop ((v1 vec1) (v2 vec2) (acc '()))
      (cond
        ((null? v1) (append acc v2))
        ((null? v2) (append acc v1))
        ((> (car v1) (car v2)) (loop (cdr v1) v2 (cons (car v1) acc)))
        ((< (car v1) (car v2)) (loop v1 (cdr v2) (cons (car v2) acc)))
        (else (loop (cdr v1) (cdr v2) (cons (car v1) acc))))))

  (define (getMaxArray nums len)
    (let loop ((nums nums) (len len) (result '()))
      (if (or (null? nums) (= len 0))
          (reverse result)
          (let ((idx (index (lambda (x) (<= x (car nums))) (list->vector nums))))
            (if (not idx)
                (reverse (cons (car nums) result))
                (loop (remove-at nums idx) (- len 1) (cons (vector-ref nums idx) result)))))))

  (define (getMax nums1 nums2 k)
    (define max-result '())
    (for ((i (in-range (min (length nums1) k) (- k (max 0 (length nums2))) -1)))
      (define max1 (getMaxArray nums1 i))
      (define max2 (getMaxArray nums2 (- k i)))
      (define current (merge max1 max2))
      (set! max-result (max max-result current)))
    max-result)

  (getMax nums1 nums2 k))

(define (remove-at lst index)
  (if (= index 0)
      (cdr lst)
      (cons (car lst) (remove-at (cdr lst) (- index 1)))))

(define (index pred vec)
  (for/fold ([result #f]) ([i (in-range (vector-length vec))])
    (if (and (not result) (pred (vector-ref vec i)))
        i
        result)))

(define (max a b)
  (if (foldl (lambda (x y) (or x y)) #f (map (lambda (x y) (> x y)) a b))
      a
      b))