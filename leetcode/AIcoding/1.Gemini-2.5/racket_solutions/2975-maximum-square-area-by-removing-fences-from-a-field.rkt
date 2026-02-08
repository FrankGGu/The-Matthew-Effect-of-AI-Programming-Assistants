#lang racket

(define (max-square-area-by-removing-fences-from-a-field n m h v)
  (define (get-all-coords count fences)
    (sort (remove-duplicates (cons 1 (cons (+ count 1) fences))) <))

  (define h-coords (get-all-coords n h))
  (define v-coords (get-all-coords m v))

  (define max-possible-coord (max (+ n 1) (+ m 1)))

  (define h-diffs (make-vector (+ max-possible-coord 1) #f))
  (define v-diffs (make-vector (+ max-possible-coord 1) #f))

  (define (populate-diffs coords diff-vector)
    (for ([i (range (length coords))])
      (for ([j (range (add1 i) (length coords))])
        (vector-set! diff-vector (- (list-ref coords j) (list-ref coords i)) #t))))

  (populate-diffs h-coords h-diffs)
  (populate-diffs v-coords v-diffs)

  (define max-s 0)
  (for ([s (range 1 (+ max-possible-coord 1))])
    (when (and (vector-ref h-diffs s) (vector-ref v-diffs s))
      (set! max-s s)))

  (* max-s max-s))