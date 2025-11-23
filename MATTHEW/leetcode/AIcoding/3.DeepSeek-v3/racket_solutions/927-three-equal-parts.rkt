(define/contract (three-equal-parts arr)
  (-> (listof exact-integer?) (listof exact-integer?))
  (let* ([ones (count (lambda (x) (= x 1)) arr)]
         [n (length arr)])
    (cond
      [(= ones 0) (list 0 (- n 1))]
      [(not (zero? (modulo ones 3))) (list -1 -1)]
      [else
       (let* ([target-ones (/ ones 3)]
              [first-1 (find-nth-1 arr 1)]
              [second-1 (find-nth-1 arr (+ 1 target-ones))]
              [third-1 (find-nth-1 arr (+ 1 (* 2 target-ones)))]
              [len (- n third-1)])
         (if (and (<= (+ first-1 len) second-1)
                  (<= (+ second-1 len) third-1)
             (let ([i (- (+ first-1 len) 1)]
                   [j (+ second-1 len)])
               (if (valid-parts? arr i j)
                   (list i j)
                   (list -1 -1)))
             (list -1 -1)))])))

(define (find-nth-1 arr n)
  (let loop ([i 0] [count 0])
    (cond
      [(= count n) i]
      [(= (list-ref arr i) 1) (loop (+ i 1) (+ count 1))]
      [else (loop (+ i 1) count)])))

(define (valid-parts? arr i j)
  (let* ([part1 (take (drop arr 0) (+ i 1))]
         [part2 (take (drop arr (+ i 1)) (- j i 1))]
         [part3 (drop arr j)])
    (equal? part1 part2 part3)))