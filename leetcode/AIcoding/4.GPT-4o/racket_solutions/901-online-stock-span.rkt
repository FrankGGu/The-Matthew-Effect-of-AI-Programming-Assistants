(define (StockSpanner)
  (define spans '())
  (define stack '())

  (define (next span)
    (let loop ((index 0))
      (cond
        [(= index (length spans)) (begin (set! spans (append spans (list span))) 1)]
        [(> span (list-ref spans index)) (loop (+ index 1))]
        [else (begin (set! spans (append spans (list span))) (+ index 1))])))

  (define (next-span price)
    (let loop ((index (sub1 (length spans))) (count 1))
      (if (and (>= index 0) (> (list-ref spans index) price))
          (loop (sub1 index) (+ count 1))
          count)))

  (define (add price)
    (next price)
    (next-span price))

  (lambda ()
    (define (add-price price)
      (add price))
    (define (get-spans) spans)
    (list add-price get-spans)))