(define/contract (find-first-almost-equal s t max-cost)
  (-> string? string? exact-integer? exact-integer?)
  (let loop ((i 0) (j 0) (cost 0) (max-len 0) (start 0))
    (cond
      [(or (>= i (string-length s)) (>= j (string-length t))] start)
      [(<= cost max-cost)
       (let ((new-cost (+ cost (abs (- (char->integer (string-ref s i)) (char->integer (string-ref t j))))))
         (if (<= new-cost max-cost)
             (loop (add1 i) (add1 j) new-cost (max max-len (add1 (- i start))) start)
             (loop (add1 start) (add1 start) 0 max-len (add1 start))))]
      [else (loop (add1 start) (add1 start) 0 max-len (add1 start))])))