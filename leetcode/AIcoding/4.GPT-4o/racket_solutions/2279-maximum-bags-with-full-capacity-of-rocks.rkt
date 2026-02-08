(define (maximum-bags capacity rocks additional)
  (define n (length capacity))
  (define remaining (map (lambda (c r) (- c r)) capacity rocks))
  (define sorted-remaining (sort remaining <))
  (define additional-sorted (sort additional <))

  (define (count-bags idx additional-left)
    (if (or (>= idx n) (<= additional-left 0))
        idx
        (let ((needed (list-ref sorted-remaining idx)))
          (if (>= needed additional-left)
              idx
              (count-bags (+ idx 1) (- additional-left needed))))))

  (count-bags 0 (apply + additional-sorted)))

(maximum-bags (vector 2 3 4) (vector 1 2 3) (vector 1 1 0))