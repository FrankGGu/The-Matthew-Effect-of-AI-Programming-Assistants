(define (num-boats-to-save-people people limit)
  (define (helper people left right count)
    (cond [(> left right) count]
          [(<= (+ (list-ref people left) (list-ref people right)) limit)
           (helper people (+ left 1) (- right 1) (+ count 1))]
          [else (helper people left (- right 1) (+ count 1))]))
  (helper (sort people <) 0 (- (length people) 1) 0))