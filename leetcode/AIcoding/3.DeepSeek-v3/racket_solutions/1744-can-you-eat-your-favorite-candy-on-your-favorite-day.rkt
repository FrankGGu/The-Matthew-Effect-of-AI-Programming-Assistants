(define/contract (can-eat-favorite-candy candiesCount queries)
  (-> (listof exact-integer?) (listof (listof exact-integer?)) (listof boolean?))
  (define prefix (make-vector (add1 (length candiesCount)) 0))
  (for ([i (in-range (length candiesCount))])
    (vector-set! prefix (add1 i) (+ (vector-ref prefix i) (list-ref candiesCount i))))
  (define (answer query)
    (match-let ([(list favorite-type favorite-day daily-cap) query])
      (let* ([min-days (vector-ref prefix favorite-type)]
             [max-days (vector-ref prefix (add1 favorite-type))]
             [min-eat (add1 favorite-day)]
             [max-eat (* (add1 favorite-day) daily-cap)])
        (and (< min-days max-eat) (< favorite-day max-days)))))
  (map answer queries))