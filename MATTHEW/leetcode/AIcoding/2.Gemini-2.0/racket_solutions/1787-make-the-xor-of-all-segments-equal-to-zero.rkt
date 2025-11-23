(define (min-changes nums k)
  (define n (length nums))
  (define (count-equal lst val)
    (count (lambda (x) (= x val)) lst))

  (define (solve idx target)
    (let loop ((i idx) (current-changes 0))
      (cond
        [(>= i n) current-changes]
        [else
         (loop (+ i k) (+ current-changes (if (= (list-ref nums i) target) 0 1)))])))

  (define (find-min-changes)
    (letrec ((helper (i)
              (if (= i k)
                  0
                  (let* ((sub-list (filter-map (lambda (j) (if (< j n) (list-ref nums j) #f)) (range i n k)))
                         (unique-vals (remove-duplicates sub-list))
                         (counts (map (lambda (v) (count-equal sub-list v)) unique-vals))
                         (max-count (if (empty? counts) 0 (apply max counts)))
                         (num-changes (- (length sub-list) max-count))))
                    (+ num-changes (helper (+ i 1)))))))
      (helper 0)))

  (define (find-best-xor)
    (letrec ((helper (i current-xor)
              (if (= i k)
                  current-xor
                  (let* ((sub-list (filter-map (lambda (j) (if (< j n) (list-ref nums j) #f)) (range i n k)))
                         (unique-vals (remove-duplicates sub-list))
                         (best-xor (foldl (lambda (v acc)
                                             (min acc (+ (count (lambda (x) (not (= x v))) sub-list) v)))
                                         (if (empty? sub-list) 0 1000000000) unique-vals)))
                    (helper (+ i 1) (bitwise-xor current-xor (if (empty? sub-list) 0 best-xor)))))))
      (helper 0 0)))

  (define (find-min-changes-optimal)
    (let* ((xor-val (find-best-xor))
           (dp (make-vector (+ 1 (length nums)) 1000000000)))
      (vector-set! dp 0 0)
      (for ((i (in-range 1 (+ 1 (length nums)))))
        (for ((j (in-range 1 (+ 1 (min i k)))))
          (vector-set! dp i (min (vector-ref dp i) (+ (vector-ref dp (- i j))
                                                     (if (= (bitwise-xor xor-val (list-ref nums (- i 1)))) 0 1))))))
      (vector-ref dp (length nums))))
  (find-min-changes))