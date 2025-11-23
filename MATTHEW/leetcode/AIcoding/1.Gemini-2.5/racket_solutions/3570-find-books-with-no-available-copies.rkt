#lang racket
(require racket/set)

(define (find-books-with-no-available-copies books orders)
  (let* ((ordered-book-ids (map (lambda (order) (second order)) orders))
         (ordered-book-id-set (list->set ordered-book-ids)))
    (filter (lambda (book)
              (not (set-member? ordered-book-id-set (first book))))
            books)))