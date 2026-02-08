(define (find-rotate-steps ring key)
  (define ring-len (string-length ring))
  (define key-len (string-length key))
  (define memo (make-hash))

  (define (solve k_idx r_pos)
    (cond
      [(= k_idx key-len) 0]
      [(hash-has-key? memo (list k_idx r_pos))
       (hash-ref memo (list k_idx r_pos))]
      [else
       (let* ((current-key-char (string-ref key k_idx))
              (min-total-steps +inf.0))
         (for ([next-r-pos (in-range ring-len)])
           (when (char=? (string-ref ring next-r-pos) current-key-char)
             (let* ((diff (abs (- r_pos next-r-pos)))
                    (rotation-cost (min diff (- ring-len diff)))
                    (current-total-steps (+ rotation-cost 1 (solve (+ k_idx 1) next-r-pos))))
               (set! min-total-steps (min min-total-steps current-total-steps)))))
         (hash-set! memo (list k_idx r_pos) min-total-steps)
         min-total-steps)]))

  (solve 0 0))