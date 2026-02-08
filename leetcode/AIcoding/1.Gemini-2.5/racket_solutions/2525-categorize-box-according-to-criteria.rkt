(define (categorize-box length width height mass)
  (let* ((volume (* length width height))
         (is-bulky
          (or (>= length 10000)
              (>= width 10000)
              (>= height 10000)
              (>= volume 1000000000)))
         (is-heavy (>= mass 100)))
    (cond
      ((and is-bulky is-heavy) "Both")
      (is-bulky "Bulky")
      (is-heavy "Heavy")
      (else "Neither"))))