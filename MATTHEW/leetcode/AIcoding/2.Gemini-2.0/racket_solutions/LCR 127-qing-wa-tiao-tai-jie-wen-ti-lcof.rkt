(define (minimum-added-coins coins target)
  (let loop ((i 0) (curr-target target) (count 0))
    (cond
      ((= curr-target 0) count)
      ((and (< i (length coins)) (<= (list-ref coins i) curr-target))
       (loop (+ i 1) (- curr-target (list-ref coins i)) count))
      (else
       (loop i (- curr-target (min curr-target (if (empty? coins) curr-target (if (< i (length coins)) (list-ref coins i) curr-target)))) (+ count 1))))))