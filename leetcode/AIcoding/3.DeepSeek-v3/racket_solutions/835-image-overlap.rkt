(define (largest-overlap img1 img2)
  (define n (length img1))
  (define max-overlap 0)

  (define (count-overlap dx dy)
    (let loop ((i 0) (j 0) (count 0))
      (cond
        [(>= i n) count]
        [(>= j n) (loop (add1 i) 0 count)]
        [else
         (let* ((new-i (+ i dx))
                (new-j (+ j dy)))
           (if (and (>= new-i 0) (< new-i n) (>= new-j 0) (< new-j n)
                    (= (list-ref (list-ref img1 i) j) 1)
                    (= (list-ref (list-ref img2 new-i) new-j) 1))
               (loop i (add1 j) (add1 count))
               (loop i (add1 j) count)))])))

  (for* ([dx (in-range (- 1 n) n)]
         [dy (in-range (- 1 n) n)])
    (set! max-overlap (max max-overlap (count-overlap dx dy))))

  max-overlap)