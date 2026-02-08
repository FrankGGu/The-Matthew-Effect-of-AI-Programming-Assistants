#lang racket

(require racket/hash)
(require racket/vector)
(require data/queue)

(define (find-all-possible-recipes recipes ingredients supplies)

  (define recipes-vec (list->vector recipes))
  (define num-recipes (vector-length recipes-vec))

  (define available (make-hash-set))
  (for-each (lambda (s) (hash-set-add! available s)) supplies)

  (define in-degree (make-vector num-recipes 0))

  (define ingredient-to-recipes-map (make-hash))

  (for-each (lambda (recipe-idx recipe-ingredients)
              (for-each (lambda (ingredient-name)
                          (unless (hash-set-member? available ingredient-name)
                            (vector-set! in-degree recipe-idx
                                         (+ (vector-ref in-degree recipe-idx) 1)))
                          (hash-set! ingredient-to-recipes-map
                                     ingredient-name
                                     (cons recipe-idx (hash-ref ingredient-to-recipes-map ingredient-name '())))))
                        (range num-recipes)
                        ingredients)

  (define q (make-queue))
  (define result '())

  (for-each (lambda (recipe-idx)
              (when (= (vector-ref in-degree recipe-idx) 0)
                (queue-push! q (vector-ref recipes-vec recipe-idx))))
            (range num-recipes))

  (while (not (queue-empty? q))
    (define current-recipe-name (queue-pop! q))
    (set! result (cons current-recipe-name result))

    (hash-set-add! available current-recipe-name)

    (define dependent-recipe-indices (hash-ref ingredient-to-recipes-map current-recipe-name '()))
    (for-each (lambda (dependent-recipe-idx)
                (vector-set! in-degree dependent-recipe-idx
                             (- (vector-ref in-degree dependent-recipe-idx) 1))
                (when (= (vector-ref in-degree dependent-recipe-idx) 0)
                  (queue-push! q (vector-ref recipes-vec dependent-recipe-idx))))
              dependent-recipe-indices))

  (reverse result))