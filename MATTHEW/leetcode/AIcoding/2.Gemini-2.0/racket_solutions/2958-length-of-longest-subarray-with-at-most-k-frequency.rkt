(define (longest-subarray-with-at-most-k-frequency nums k)
  (let ((n (length nums)))
    (let loop ((left 0) (right 0) (freq (make-hash)) (max-len 0))
      (cond
        ((= right n) max-len)
        (else
         (let* ((num (list-ref nums right))
                (new-freq (hash-update freq num (λ (v) (+ v 1)) 1)))
           (let check-freq ((new-left left) (new-freq new-freq))
             (cond
               ((>= (hash-ref new-freq num) k)
                (let* ((left-num (list-ref nums new-left))
                       (new-new-freq (hash-update new-freq left-num (λ (v) (- v 1)))))
                  (check-freq (+ new-left 1) new-new-freq)))
               (else
                (loop left (+ right 1) new-freq (max max-len (- (+ right 1) left))))))))))))