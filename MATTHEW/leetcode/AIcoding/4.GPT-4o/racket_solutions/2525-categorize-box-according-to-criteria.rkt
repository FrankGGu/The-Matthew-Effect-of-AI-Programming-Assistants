(define (categorize-box length width height weight)
  (define volume (* length width height))
  (define is-heavy (> weight 100))
  (define is-bulky (or (> volume 10000000) (or (> length 100) (> width 100) (> height 100))))
  (cond
    [(and is-heavy is-bulky) "Both"]
    [(or is-heavy is-bulky) (if is-heavy "Heavy" "Bulky")]
    [else "Light"])
)

(define (categorizeBox length width height weight)
  (categorize-box length width height weight)
)