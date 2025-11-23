(define (flood-fill image sr sc new-color)
  (define rows (vector-length image))
  (define cols (vector-length (vector-ref image 0)))
  (define old-color (vector-ref (vector-ref image sr) sc))

  (define (valid? r c)
    (and (>= r 0) (< r rows) (>= c 0) (< c cols)))

  (define (dfs r c)
    (when (and (valid? r c) (= (vector-ref (vector-ref image r) c) old-color) (not (= (vector-ref (vector-ref image r) c) new-color)))
      (vector-set! (vector-ref image r) c new-color)
      (dfs (+ r 1) c)
      (dfs (- r 1) c)
      (dfs r (+ c 1))
      (dfs r (- c 1))))

  (when (not (= old-color new-color))
    (dfs sr sc))
  image)