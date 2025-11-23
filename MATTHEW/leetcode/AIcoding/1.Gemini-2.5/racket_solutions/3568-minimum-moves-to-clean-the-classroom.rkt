#lang racket

(define (make-mutable-queue)
  (list '() '()))

(define (mutable-queue-empty? q)
  (and (null? (car q)) (null? (cadr q))))

(define (mutable-queue-put! q item)
  (set-car! (cdr q) (cons item (cadr q))))

(define (mutable-queue-get! q)
  (if (null? (car q))
      (begin
        (set-car! q (reverse (cadr q)))
        (set-car! (cdr q) '()))
      #f)
  (car (car q)))

(define (mutable-queue-pop! q)
  (if (null? (car q))
      (begin
        (set-car! q (reverse (cadr q)))
        (set-car! (cdr q) '()))
      #f)
  (set-car! q (cdr (car q))))

(define (minimum-moves-to-clean-the-classroom classroom)
  (define rows (length classroom))
  (define cols (if (null? classroom) 0 (string-length (car classroom))))

  (cond
    [(zero? rows) 0]
    [else
     (let ()
       (define start-r -1)
       (define start-c -1)
       (define clean-spots '())
       (define clean-spot-map (make-hash))

       (for ([r (in-range rows)])
         (for ([c (in-range cols)])
           (define char (string-ref (list-ref classroom r) c))
           (case char
             [#\S (set! start-r r) (set! start-c c)]
             [#\C (begin
                    (set! clean-spots (append clean-spots (list (list r c))))
                    (hash-set! clean-spot-map (cons r c) (sub1 (length clean-spots))))]
             [else #f])))

       (define num-clean-spots (length clean-spots))
       (define target-mask (if (= num-clean-spots 0) 0 (sub1 (expt 2 num-clean-spots))))

       (cond
         [(zero? num-clean-spots) 0]
         [(or (= start-r -1) (= start-c -1)) -1]
         [else
          (let ()
            (define q (make-mutable-queue))
            (define visited (make-hash))

            (mutable-queue-put! q (list start-r start-c 0 0))
            (hash-set! visited (list start-r start-c 0) #t)

            (define (valid-pos? r c)
              (and (>= r 0) (< r rows) (>= c 0) (< c cols)
                   (not (char=? #\# (string-ref (list-ref classroom r) c)))))

            (define dr '(-1 1 0 0))
            (define dc '(0 0 -1 1))

            (let bfs-loop ()
              (if (mutable-queue-empty? q)
                  -1
                  (let* ((current-state (mutable-queue-get! q)))
                    (mutable-queue-pop! q)
                    (define r (list-ref current-state 0))
                    (define c (list-ref current-state 1))
                    (define mask (list-ref current-state 2))
                    (define moves (list-ref current-state 3)))

                    (define current-cell-mask mask)
                    (when (hash-has-key? clean-spot-map (cons r c))
                      (define spot-idx (hash-ref clean-spot-map (cons r c)))
                      (set! current-cell-mask (bitwise-ior mask (expt 2 spot-idx))))

                    (if (= current-cell-mask target-mask)
                        moves
                        (begin
                          (for ([i (in-range 4)])
                            (define nr (+ r (list-ref dr i)))
                            (define nc (+ c (list-ref dc i)))

                            (when (valid-pos? nr nc)
                              (define next-mask current-cell-mask)
                              (when (hash-has-key? clean-spot-map (cons nr nc))
                                (define spot-idx (hash-ref clean-spot-map (cons nr nc)))
                                (set! next-mask (bitwise-ior current-cell-mask (expt 2 spot-idx))))

                              (define next-state-key (list nr nc next-mask))
                              (when (not (hash-has-key? visited next-state-key))
                                (hash-set! visited next-state-key #t)
                                (mutable-queue-put! q (list nr nc next-mask (add1 moves))))))
                          (bfs-loop)))))]))))