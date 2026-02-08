#lang racket

(define (count-smaller-after-self nums)
  (define n (vector-length nums))
  (define counts (make-vector n 0))

  (define (merge left right)
    (let loop ((l-list left) (r-list right) (merged-acc '()) (right-elements-count 0))
      (cond
        ((null? l-list)
         (append (reverse merged-acc) r-list))
        ((null? r-list)
         (let add-remaining-left ((curr-l l-list) (acc merged-acc))
           (if (null? curr-l)
               (reverse acc)
               (let* ((idx (cdr (car curr-l))))
                 (vector-set! counts idx (+ (vector-ref counts idx) right-elements-count))
                 (add-remaining-left (cdr curr-l) (cons (car curr-l) acc))))))
        (else
         (let* ((l-pair (car l-list))
                (r-pair (car r-list))
                (l-val (car l-pair))
                (r-val (car r-pair)))
           (if (<= l-val r-val)
               (begin
                 (vector-set! counts (cdr l-pair) (+ (vector-ref counts (cdr l-pair)) right-elements-count))
                 (loop (cdr l-list) r-list (cons l-pair merged-acc) right-elements-count))
               (loop l-list (cdr r-list) (cons r-pair merged-acc) (+ right-elements-count 1))))))))

  (define (merge-sort items)
    (define len (length items))
    (cond
      ((<= len 1) items)
      (else
       (let* ((mid (quotient len 2))
              (left-half (take items mid))
              (right-half (drop items mid))
              (sorted-left (merge-sort left-half))
              (sorted-right (merge-sort right-half)))
         (merge sorted-left sorted-right)))))

  (define initial-items
    (for/list ((i (in-range n)))
      (cons (vector-ref nums i) i)))

  (merge-sort initial-items)

  counts)