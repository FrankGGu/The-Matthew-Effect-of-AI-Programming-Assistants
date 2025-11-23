#lang racket

(define/contract (count-unique-subjects teacher)
  (-> (listof (listof exact-integer?)) (listof (listof exact-integer?)))
  (define h (make-hash))
  (for ([t (in-list teacher)])
    (let ([teacher-id (first t)]
          [subject-id (second t)])
      (hash-update! h teacher-id 
                    (lambda (subjects) (set-add subjects subject-id))
                    (set)))
  (sort (hash-map h (lambda (k v) (list k (set-count v)))) < #:key car))
)