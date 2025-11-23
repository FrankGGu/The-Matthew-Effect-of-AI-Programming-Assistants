#lang racket

(require racket/list)
(require racket/vector)

(define (factorial n)
  (if (<= n 1)
      1
      (* n (factorial (- n 1)))))

(define (calculate-sum-abs-diff A B)
  (define n (length A))
  (if (= n 0)
      0
      (begin
        (define B-sorted (sort B <))
        (define B-vec (list->vector B-sorted))

        (define prefix-sums (make-vector (+ n 1) 0))
        (for ([i (in-range n)])
          (vector-set! prefix-sums (+ i 1) (+ (vector-ref prefix-sums i) (vector-ref B-vec i))))

        (define total-sum 0)
        (for ([a A])
          ;; 's' is the count of elements in B-vec that are less than or equal to 'a'.
          ;; (vector-binary-search B-vec (lambda (val) (> val a))) returns the index of the first element in B-vec that is greater than 'a'.
          ;; This index is precisely the count of elements that are less than or equal to 'a'.
          (define s (vector-binary-search B-vec (lambda (val) (> val a))))

          ;; sum-le: sum of B-vec[0]...B-vec[s-1] (elements <= a)
          (define sum-le (vector-ref prefix-sums s))
          ;; sum-gt: sum of B-vec[s]...B-vec[n-1] (elements > a)
          (define sum-gt (- (vector-ref prefix-sums n) sum-le))

          ;; Calculate sum_{k=0 to n-1} |a - B_vec[k]| for the current 'a'
          ;; This is equivalent to:
          ;; sum_{k=0 to s-1} (a - B_vec[k]) + sum_{k=s to n-1} (B_vec[k] - a)
          ;; = (s * a - sum-le) + (sum-gt - (n - s) * a)
          (define current-a-sum
            (+ (- (* s a) sum-le)
               (- sum-gt (* (- n s) a))))

          (set! total-sum (+ total-sum current-a-sum)))
        total-sum)))

(define (solution n pieces targets)
  (if (= n 0)
      0
      (begin
        (define fact-n-minus-1 (factorial (- n 1)))

        (define x-coords (map first pieces))
        (define y-coords (map second pieces))

        (define p-coords (map first targets))
        (define q-coords (map second targets))

        (define sum-abs-diff-x (calculate-sum-abs-diff x-coords p-coords))
        (define sum-abs-diff-y (calculate-sum-abs-diff y-coords q-coords))

        (* fact-n-minus-1 (+ sum-abs-diff-x sum-abs-diff-y)))))