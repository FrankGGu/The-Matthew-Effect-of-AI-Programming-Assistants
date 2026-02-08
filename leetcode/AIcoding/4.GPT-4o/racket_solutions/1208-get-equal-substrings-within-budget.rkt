(define (equal-substrings s t max-cost)
  (define (helper s t max-cost)
    (let loop ((left 0) (right 0) (current-cost 0) (max-length 0))
      (if (>= right (string-length s))
          max-length
          (begin
            (set! current-cost (+ current-cost (abs (- (char->integer (string-ref s right))
                                                       (char->integer (string-ref t right))))))
            (if (<= current-cost max-cost)
                (begin
                  (set! max-length (max max-length (- right left)))
                  (loop left (+ right 1) current-cost max-length))
                (begin
                  (set! current-cost (- current-cost (abs (- (char->integer (string-ref s left))
                                                             (char->integer (string-ref t left))))))
                  (loop (+ left 1) right current-cost max-length)))))))
  (helper s t max-cost))

(define (get-equal-substrings s t max-cost)
  (equal-substrings s t max-cost))