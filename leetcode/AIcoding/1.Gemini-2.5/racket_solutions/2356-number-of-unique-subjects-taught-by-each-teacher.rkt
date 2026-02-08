#lang racket

(define (unique-subjects-by-teacher records)
  (define teachers-subjects (make-hash))

  (for-each (lambda (record)
              (define teacher-id (first record))
              (define subject-id (second record))
              (hash-set! teachers-subjects
                         teacher-id
                         (cons subject-id (hash-ref teachers-subjects teacher-id '()))))
            records)

  (define result-list
    (hash-map teachers-subjects
              (lambda (teacher-id subjects-list)
                (list teacher-id (set-count (list->set subjects-list))))))

  (sort result-list (lambda (a b) (< (first a) (first b)))))