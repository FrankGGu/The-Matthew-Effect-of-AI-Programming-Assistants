(define (least-bricks wall)
  (let* ((height (length wall))
         (width (if (null? wall) 0 (apply + (car wall))))
         (freq (make-hash))
         (max-freq 0))
    (for ([row (in-list wall)])
      (let loop ([bricks row] [pos 0])
        (cond
          [(null? (cdr bricks)) #void]
          [else
           (let* ((new-pos (+ pos (car bricks)))
                  (count (hash-ref freq new-pos 0)))
             (hash-set! freq new-pos (+ count 1))
             (set! max-freq (max max-freq (+ count 1)))
             (loop (cdr bricks) new-pos))])))
    (- height max-freq)))