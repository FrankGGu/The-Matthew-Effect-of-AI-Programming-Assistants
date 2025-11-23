(define (minimum-cost-for-cutting-cake m n horizontalCut verticalCut)
  (let* ([sorted-h-cuts (sort horizontalCut >)]
         [sorted-v-cuts (sort verticalCut >)]
         [h-len (length sorted-h-cuts)]
         [v-len (length sorted-v-cuts)])

    (let loop ([h-idx 0]
               [v-idx 0]
               [total-cost 0]
               [h-pieces 1]
               [v-pieces 1])
      (cond
        [(and (= h-idx h-len) (= v-idx v-len))
         total-cost]

        [(and (< h-idx h-len)
              (or (= v-idx v-len)
                  (>= (list-ref sorted-h-cuts h-idx) (list-ref sorted-v-cuts v-idx))))
         (loop (+ h-idx 1)
               v-idx
               (+ total-cost (* (list-ref sorted-h-cuts h-idx) v-pieces))
               (+ h-pieces 1)
               v-pieces)]

        [else
         (loop h-idx
               (+ v-idx 1)
               (+ total-cost (* (list-ref sorted-v-cuts v-idx) h-pieces))
               h-pieces
               (+ v-pieces 1))]))))