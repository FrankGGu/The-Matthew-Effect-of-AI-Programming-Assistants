#lang racket

(define (find-duplicate-subtrees root)
  (define seen (make-hash))
  (define result '())

  (define (traverse node)
    (if (not node)
        "#"
        (let* ([left (traverse (send node get-left))]
               [right (traverse (send node get-right))]
               [serial (string-append (number->string (send node get-val)) "," left "," right)])
          (hash-update! seen serial (lambda (v) (add1 v))
                        (lambda () 0))
          (when (= (hash-ref seen serial) 2)
            (set! result (cons node result)))
          serial)))

  (traverse root)
  result)