#lang racket

(define (find-category-recommendation-pairs product-categories)
  (define category-map (make-hash))
  (for ([pc product-categories])
    (match-define (list product category) pc)
    (hash-update! category-map product (λ (cats) (cons category cats)) (list category)))

  (define product-list (hash-keys category-map))
  (define result (mutable-set))

  (for ([i (in-range (length product-list))])
    (for ([j (in-range (add1 i) (length product-list))])
      (define p1 (list-ref product-list i))
      (define p2 (list-ref product-list j))
      (define cats1 (hash-ref category-map p1))
      (define cats2 (hash-ref category-map p2))
      (define common (set-intersect (list->set cats1) (list->set cats2)))
      (when (not (set-empty? common))
        (set-add! result (sort (list p1 p2) string<?)))))

  (sort (set->list result)
        (λ (a b)
          (or (string<? (first a) (first b))
              (and (string=? (first a) (first b))
                   (string<? (second a) (second b))))))))