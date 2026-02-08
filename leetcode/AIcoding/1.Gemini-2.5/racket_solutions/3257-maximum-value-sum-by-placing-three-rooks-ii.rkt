#lang racket

(define (maximum-value-sum-by-placing-three-rooks-ii board)
  (define m (length board))
  (define n (length (car board)))

  (if (or (< m 3) (< n 3))
      0
      (begin
        (define row-top-vals
          (build-list m
                      (lambda (r)
                        (take (sort (build-list n (lambda (c) (cons (list-ref (list-ref board r) c) c)))
                                    (lambda (a b) (> (car a) (car b))))
                              3))))

        (define (get-top-k-excluding-col row-idx k c-excl)
          (define filtered-vals
            (filter (lambda (vc-pair)
                      (not (= (cdr vc-pair) c-excl)))
                    (list-ref row-top-vals row-idx)))
          (take filtered-vals k))

        (define max-total-sum -inf.0)

        (for ([r1 (in-range m)])
          (for ([r2 (in-range m)])
            (unless (= r1 r2)
              (for ([r3 (in-range m)])
                (unless (or (= r3 r1) (= r3 r2))
                  (define current-rows-max-sum -inf.0)

                  (for ([c1 (in-range n)])
                    (define val-r1-c1 (list-ref (list-ref board r1) c1))

                    (define max-pair-sum-for-r2-r3 -inf.0)

                    (define r2-top-2 (get-top-k-excluding-col r2 2 c1))
                    (define r3-top-2 (get-top-k-excluding-col r3 2 c1))

                    (when (and (not (empty? r2-top-2)) (not (empty? r3-top-2)))
                      (define v2-1 (caar r2-top-2))
                      (define c2-1 (cdar r2-top-2))
                      (define v3-1 (caar r3-top-2))
                      (define c3-1 (cdar r3-top-2))

                      (when (not (= c2-1 c3-1))
                        (set! max-pair-sum-for-r2-r3
                              (max max-pair-sum-for-r2-r3 (+ v2-1 v3-1))))

                      (when (and (> (length r2-top-2) 1) (not (= (cdr (list-ref r2-top-2 1)) c3-1)))
                        (set! max-pair-sum-for-r2-r3
                              (max max-pair-sum-for-r2-r3 (+ (car (list-ref r2-top-2 1)) v3-1))))

                      (when (and (> (length r3-top-2) 1) (not (= c2-1 (cdr (list-ref r3-top-2 1)))))
                        (set! max-pair-sum-for-r2-r3
                              (max max-pair-sum-for-r2-r3 (+ v2-1 (car (list-ref r3-top-2 1))))))

                      (when (and (> (length r2-top-2) 1) (> (length r3-top-2) 1)
                                 (not (= (cdr (list-ref r2-top-2 1)) (cdr (list-ref r3-top-2 1)))))
                        (set! max-pair-sum-for-r2-r3
                              (max max-pair-sum-for-r2-r3 (+ (car (list-ref r2-top-2 1)) (car (list-ref r3-top-2 1)))))))

                    (when (not (eq? max-pair-sum-for-r2-r3 -inf.0))
                      (set! current-rows-max-sum
                            (max current-rows-max-sum (+ val-r1-c1 max-pair-sum-for-r2-r3)))))

                  (when (not (eq? current-rows-max-sum -inf.0))
                    (set! max-total-sum (max max-total-sum current-rows-max-sum))))))))
        max-total-sum)))