#lang racket

(require data/heap)
(require data/collection)

(define (maximum-elegance items k)
  ;; Sort items by profit in descending order.
  (define sorted-items (sort items (lambda (a b) (> (car a) (car b)))))

  (define current-profit 0)
  (define current-categories (set)) ; Hash set for O(1) average access
  (define duplicate-profits-pq (make-heap <)) ; Min-heap to store profits of duplicate-category items

  (define max-elegance 0)

  ;; Phase 1: Select the first k items based on highest profit.
  ;; Populate initial current-profit, current-categories, and duplicate-profits-pq.
  (for ([i (in-range k)])
    (define item (list-ref sorted-items i))
    (define profit (car item))
    (define category (cadr item))

    (set! current-profit (+ current-profit profit))
    (if (set-contains? current-categories category)
        (heap-add! duplicate-profits-pq profit) ; Category already seen, this profit is a duplicate
        (set! current-categories (set-add current-categories category)))) ; New category

  ;; Calculate initial elegance with the first k items.
  (set! max-elegance (+ current-profit (* (set-count current-categories) (set-count current-categories))))

  ;; Phase 2: Iterate through the remaining items (those not in the initial k).
  ;; Try to improve elegance by replacing a duplicate-category item with a new-category item.
  (for ([i (in-range k (length sorted-items))])
    (define item (list-ref sorted-items i))
    (define profit (car item))
    (define category (cadr item))

    ;; If the current item offers a new category AND we have a duplicate item to replace
    (when (and (not (set-contains? current-categories category))
               (not (heap-empty? duplicate-profits-pq)))
      ;; Remove the smallest profit item that is part of a duplicate category
      (define smallest-duplicate-profit (heap-min duplicate-profits-pq))
      (heap-remove-min! duplicate-profits-pq)

      ;; Update current profit by removing the old item and adding the new one
      (set! current-profit (- current-profit smallest-duplicate-profit))
      (set! current-profit (+ current-profit profit))

      ;; Add the new category
      (set! current-categories (set-add current-categories category))

      ;; Update max-elegance
      (set! max-elegance (max max-elegance (+ current-profit (* (set-count current-categories) (set-count current-categories)))))))

  max-elegance)