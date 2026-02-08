(define/contract (find-peak-grid mat)
  (-> (listof (listof exact-integer?)) (listof exact-integer?))
  (let loop ([i 0] [j 0] [rows (length mat)] [cols (length (car mat))])
    (let* ([current (list-ref (list-ref mat i) j)]
           [up (if (> i 0) (list-ref (list-ref mat (- i 1)) j) -1)]
           [down (if (< i (- rows 1)) (list-ref (list-ref mat (+ i 1)) j) -1)]
           [left (if (> j 0) (list-ref (list-ref mat i) (- j 1)) -1)]
           [right (if (< j (- cols 1)) (list-ref (list-ref mat i) (+ j 1)) -1)]
           [max-neighbor (max up down left right)])
      (cond
        [(>= current max-neighbor) (list i j)]
        [(= max-neighbor up) (loop (- i 1) j rows cols)]
        [(= max-neighbor down) (loop (+ i 1) j rows cols)]
        [(= max-neighbor left) (loop i (- j 1) rows cols)]
        [else (loop i (+ j 1) rows cols)]))))