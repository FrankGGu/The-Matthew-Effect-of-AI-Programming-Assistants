#lang racket

(define (find-distinct-colors colors queries)
  (let* ([current-colors (list->vector colors)]
         [color-counts (make-hash)]
         [results '()])

    ;; Initialize color-counts
    (for-each (lambda (color)
                (hash-set! color-counts color (+ (hash-ref color-counts color 0) 1)))
              colors)

    ;; Process queries
    (for-each (lambda (query)
                (let* ([index (car query)]
                       [new-color (cadr query)]
                       [old-color (vector-ref current-colors index)])

                  ;; Decrement count for old-color
                  (let ([old-count (hash-ref color-counts old-color)])
                    (if (= old-count 1)
                        (hash-remove! color-counts old-color)
                        (hash-set! color-counts old-color (- old-count 1))))

                  ;; Update the color in the vector
                  (vector-set! current-colors index new-color)

                  ;; Increment count for new-color
                  (hash-set! color-counts new-color (+ (hash-ref color-counts new-color 0) 1))

                  ;; Add current distinct count to results
                  (set! results (cons (hash-count color-counts) results))))
              queries)

    (reverse results)))