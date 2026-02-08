(define (largest-1-bordered-square grid)
  (call-with-current-continuation
   (lambda (return)
     (let* ([rows (length grid)]
            [cols (if (null? grid) 0 (length (car grid)))])

       ;; Handle empty grid or grid with empty rows
       (when (or (zero? rows) (zero? cols))
         (return 0))

       ;; Convert list of lists to vector of vectors for efficient access
       (define grid-vec (make-vector rows))
       (for ([r (in-range rows)])
         (vector-set! grid-vec r (list->vector (list-ref grid r))))

       ;; Helper to safely get value from DP tables
       ;; Returns 'default' if (r,c) is out of bounds
       (define (get-val mat r c default)
         (if (or (< r 0) (< c 0) (>= r rows) (>= c cols))
             default
             (vector-ref (vector-ref mat r) c)))

       ;; Initialize hor and ver tables
       ;; hor[r][c] stores the length of consecutive 1s ending at (r,c) to its left
       ;; ver[r][c] stores the length of consecutive 1s ending at (r,c) upwards
       (define hor (make-vector rows))
       (define ver (make-vector rows))

       (for ([r (in-range rows)])
         (vector-set! hor r (make-vector cols))
         (vector-set! ver r (make-vector cols)))

       ;; Populate hor and ver tables
       (for ([r (in-range rows)])
         (for ([c (in-range cols)])
           (let ([cell-val (vector-ref (vector-ref grid-vec r) c)])
             (if (= cell-val 1)
                 (begin
                   (vector-set! (vector-ref hor r) c (+ 1 (get-val hor r (- c 1) 0)))
                   (vector-set! (vector-ref ver r) c (+ 1 (get-val ver (- r 1) c 0))))
                 (begin
                   (vector-set! (vector-ref hor r) c 0)
                   (vector-set! (vector-ref ver r) c 0))))))

       ;; Find the largest square
       (define max-side 0)

       (for ([r (in-range rows)])
         (for ([c (in-range cols)])
           ;; max-s-for-rc is the maximum possible side length
           ;; if we only consider the bottom and right borders ending at (r,c)
           (let ([max-s-for-rc (min (get-val hor r c 0) (get-val ver r c 0))])
             ;; Iterate s downwards from max-s-for-rc to 1
             ;; Use call/cc to implement a 'break' for the inner 's' loop
             (call-with-current-continuation
              (lambda (break-s-loop)
                (for ([s (in-range max-s-for-rc 0 -1)])
                  ;; Check if the top border (hor[r-s+1][c]) and left border (ver[r][c-s+1])
                  ;; also have at least 's' consecutive 1s.
                  ;; (r - s + 1) is equivalent to (- r s -1) in Racket
                  ;; (c - s + 1) is equivalent to (- c s -1) in Racket
                  (when (and (>= (get-val hor (- r s -1) c 0) s)
                             (>= (get-val ver r (- c s -1) 0) s))
                    (set! max-side (max max-side s))
                    (break-s-loop #f)))))))) ; Exit the s loop immediately after finding the largest s for (r,c)

       (* max-side max-side)))))