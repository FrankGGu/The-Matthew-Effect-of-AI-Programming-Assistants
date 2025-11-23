(define (minOperations target)
  (let* ([s (string->list target)]
         [freq (make-hash)]
         [_ (for-each (lambda (c)
                        (hash-update! freq c (lambda (v) (+ v 1)) 1))
                      s)]
         [counts (sort (hash-values freq) >)]
         [n (length s)])
    (let loop ([i 1] [res n])
      (if (> i (length counts))
          res
          (let* ([cutoff (list-ref counts (- i 1))]
                 [cur-res 0])
            (for ([c counts])
              (when (> c cutoff)
                (set! cur-res (+ cur-res (- c cutoff)))))
            (loop (+ i 1) (min res (+ cur-res (* i (- (if (< i (length counts)) (list-ref counts i) 0) cutoff)))))))))
  )