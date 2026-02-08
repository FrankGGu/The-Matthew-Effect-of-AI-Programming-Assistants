(define (minRounds tasks)
  (define (count-rounds freq)
    (if (zero? freq) 0
      (if (= freq 1) -1
        (ceiling (/ freq 3)))))

  (define task-freq (apply hash-map 
                            (apply append 
                                   (map (lambda (x) (list x (hash-ref (hash-table-ref/default freq x 0) 0)))
                                        tasks))))

  (define total-rounds 0)
  (define result #t)

  (for ([k (hash-table-keys task-freq)])
    (let ([rounds (count-rounds (hash-table-ref task-freq k))])
      (if (= rounds -1)
          (set! result #f)
          (set! total-rounds (+ total-rounds rounds)))))

  (if result total-rounds -1))

(define (minRounds-helper tasks)
  (minRounds tasks))