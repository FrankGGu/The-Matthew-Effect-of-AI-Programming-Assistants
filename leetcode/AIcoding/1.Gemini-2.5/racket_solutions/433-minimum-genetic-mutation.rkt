#lang racket

(require racket/queue)
(require racket/set)

(define (diff s1 s2)
  (let loop ((idx 0) (diff-count 0))
    (cond
      ((= idx 8) (= diff-count 1))
      ((> diff-count 1) #f)
      ((char=? (string-ref s1 idx) (string-ref s2 idx))
       (loop (+ idx 1) diff-count))
      (else
       (loop (+ idx 1) (+ diff-count 1))))))

(define (min-mutation start end bank)
  (define q (make-queue))
  (define visited (set))

  (queue-put! q (list start 0))
  (set-add! visited start)

  (let loop ()
    (if (queue-empty? q)
        -1
        (let* ((current (queue-get! q))
               (current-seq (car current))
               (current-mutations (cadr current)))
          (if (string=? current-seq end)
              current-mutations
              (begin
                (for-each (lambda (next-seq)
                            (when (and (not (set-member? visited next-seq))
                                       (diff current-seq next-seq))
                              (set-add! visited next-seq)
                              (queue-put! q (list next-seq (+ current-mutations 1)))))
                          bank)
                (loop)))))))