#lang racket

(define (max-number nums1 nums2 k)
  (define (max-subarray nums len)
    (define n (length nums))
    (define result '())
    (define (pop-last-if-smaller stack x)
      (if (and (not (null? stack)) (> (car stack) x))
          (pop-last-if-smaller (cdr stack) x)
          stack))
    (for ([i (in-range n)])
      (set! result (append (pop-last-if-smaller result (list-ref nums i)) (list (list-ref nums i))))
      (when (> (length result) len)
        (set! result (take result len))))
    (take result len))

  (define (merge a b)
    (define (helper a b res)
      (cond [(null? a) res]
            [(null? b) res]
            [(> (car a) (car b)) (helper (cdr a) b (cons (car a) res))]
            [(< (car a) (car b)) (helper a (cdr b) (cons (car b) res))]
            [else
             (if (and (not (null? a)) (not (null? b)) (equal? (reverse a) (reverse b)))
                 (helper (cdr a) b (cons (car a) res))
                 (if (greater? a b)
                     (helper (cdr a) b (cons (car a) res))
                     (helper a (cdr b) (cons (car b) res)))]))
    (reverse (helper a b '())))

  (define (greater? a b)
    (cond [(null? a) #f]
          [(null? b) #t]
          [(> (car a) (car b)) #t]
          [(< (car a) (car b)) #f]
          [else (greater? (cdr a) (cdr b))]))

  (define max-result '())
  (define len1 (min k (length nums1)))
  (define len2 (- k len1))
  (when (and (>= len1 0) (>= len2 0) (<= len2 (length nums2)))
    (let loop ([i 0])
      (when (<= i len1)
        (let ([sub1 (max-subarray nums1 i)]
              [sub2 (max-subarray nums2 (- k i))])
          (when (and (not (null? sub1)) (not (null? sub2)))
            (let ([current (merge sub1 sub2)])
              (when (or (null? max-result) (greater? current max-result))
                (set! max-result current)))))
        (loop (+ i 1)))))
  max-result)

(define (solve)
  (define nums1 (read))
  (define nums2 (read))
  (define k (read))
  (displayln (max-number nums1 nums2 k)))

(solve)