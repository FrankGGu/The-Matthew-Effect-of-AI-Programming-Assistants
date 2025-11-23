(require srfi/1) ; For list-length, if not using built-in length
(require srfi/113) ; For set, set-count, list->set

(define (distribute-candies candyType)
  (let* ((n (length candyType))
         (max-candies-to-eat (/ n 2))
         (unique-candy-types (list->set candyType))
         (num-unique-types (set-count unique-candy-types)))
    (min num-unique-types max-candies-to-eat)))