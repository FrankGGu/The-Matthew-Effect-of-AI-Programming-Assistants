(define (minimum-cost horizontalCut verticalCut)
  (let* ([h-sorted (sort horizontalCut >)]
         [v-sorted (sort verticalCut >)]
         [h-len (length h-sorted)]
         [v-len (length v-sorted)])
    (let loop ([h-idx 0]
               [v-idx 0]
               [h-segments 1]
               [v-segments 1]
               [total-cost 0])
      (cond
        [(and (= h-idx h-len) (= v-idx v-len))
         total-cost]
        [(or (= h-idx h-len)
             (and (< v-idx v-len)
                  (< h-idx h-len)
                  (>= (list-ref v-sorted v-idx) (list-ref h-sorted h-idx))))
         (loop h-idx
               (add1 v-idx)
               h-segments
               (add1 v-segments)
               (+ total-cost (* (list-ref v-sorted v-idx) h-segments)))]
        [else
         (loop (add1 h-idx)
               v-idx
               (add1 h-segments)
               v-segments
               (+ total-cost (* (list-ref h-sorted h-idx) v-segments)))]))))