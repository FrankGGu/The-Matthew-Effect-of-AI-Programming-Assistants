(define (verify-postorder postorder)
  (define (helper start end)
    (if (<= start end)
        #t
        (let* ((root (list-ref postorder end))
               (split-point (find-split-point start end root)))
          (if (and (all-less-than postorder start split-point root)
                   (all-greater-than postorder split-point end root))
              (and (helper start (- split-point 1))
                   (helper split-point (- end 1)))
              #f))))

  (define (find-split-point start end root)
    (for/fold ([i start]) ([j (in-range start end)])
      (if (> (list-ref postorder j) root)
          (if (= i start) j i)
          i)))

  (define (all-less-than lst start end value)
    (for/all ([i (in-range start end)])
      (< (list-ref lst i) value)))

  (define (all-greater-than lst start end value)
    (for/all ([i (in-range start end)])
      (> (list-ref lst i) value)))

  (helper 0 (- (length postorder) 1)))

(define (verifyPostorder postorder)
  (verify-postorder postorder))