(define/contract (num-buses-to-destination routes source target)
  (-> (listof (listof exact-integer?)) exact-integer? exact-integer? exact-integer?)
  (if (= source target)
      0
      (let* ([stop-to-routes (make-hash)]
             [queue (make-queue)]
             [visited-routes (mutable-set)]
             [visited-stops (mutable-set)])
        (for ([route (in-list routes)]
              (for ([stop (in-list route)])
                   (hash-update! stop-to-routes stop (lambda (v) (cons route v)) '())))
        (enqueue! queue source)
        (set-add! visited-stops source)
        (let loop ([buses 1])
          (if (queue-empty? queue)
              -1
              (let ([size (queue-length queue)])
                (for ([_ (in-range size)])
                     (let ([current-stop (dequeue! queue)])
                       (for ([route (in-list (hash-ref stop-to-routes current-stop '()))])
                            (unless (set-member? visited-routes route)
                              (set-add! visited-routes route)
                              (for ([next-stop (in-list route)])
                                   (unless (set-member? visited-stops next-stop)
                                     (if (= next-stop target)
                                         buses
                                         (begin
                                           (set-add! visited-stops next-stop)
                                           (enqueue! queue next-stop)))))))))
                (loop (add1 buses))))))))