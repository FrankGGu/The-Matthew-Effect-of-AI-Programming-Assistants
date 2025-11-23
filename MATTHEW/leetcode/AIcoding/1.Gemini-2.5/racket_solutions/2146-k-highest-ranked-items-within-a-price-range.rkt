#lang racket

(require racket/queue)

(define (k-highest-ranked-items grid pricing start k)
  (define rows (length grid))
  (define cols (length (car grid)))
  (define min-price (car pricing))
  (define max-price (cadr pricing))
  (define start-r (car start))
  (define start-c (cadr start))

  (define visited (build-vector rows (lambda (_) (build-vector cols (lambda (_) #f)))))
  (define distances (build-vector rows (lambda (_) (build-vector cols (lambda (_) -1)))))

  (define q (make-queue))
  (queue-enqueue! q (list start-r start-c 0))
  (vector-set! (vector-ref visited start-r) start-c #t)
  (vector-set! (vector-ref distances start-r) start-c 0)

  (define (valid-pos r c)
    (and (>= r 0) (< r rows) (>= c 0) (< c cols)))

  (define (bfs)
    (define dr (list -1 1 0 0))
    (define dc (list 0 0 -1 1))

    (let loop ()
      (when (not (queue-empty? q))
        (define current (queue-dequeue! q))
        (define r (car current))
        (define c (cadr current))
        (define dist (caddr current))

        (for ([i (range 4)])
          (define nr (+ r (list-ref dr i)))
          (define nc (+ c (list-ref dc i)))

          (when (and (valid-pos nr nc)
                     (not (vector-ref (vector-ref visited nr) nc))
                     (not (= (list-ref (list-ref grid nr) nc) 0)))
            (vector-set! (vector-ref visited nr) nc #t)
            (vector-set! (vector-ref distances nr) nc (+ dist 1))
            (queue-enqueue! q (list nr nc (+ dist 1)))))
        (loop))))

  (bfs)

  (define ranked-items '())
  (for* ([r (range rows)]
         [c (range cols)])
    (define item-price (list-ref (list-ref grid r) c))
    (define dist (vector-ref (vector-ref distances r) c))

    (when (and (not (= dist -1))
               (not (= item-price 0))
               (>= item-price min-price)
               (<= item-price max-price))
      (set! ranked-items (cons (list dist item-price r c) ranked-items))))

  (define sorted-items
    (sort ranked-items
          (lambda (a b)
            (define dist-a (car a))
            (define price-a (cadr a))
            (define r-a (caddr a))
            (define c-a (cadddr a))

            (define dist-b (car b))
            (define price-b (cadr b))
            (define r-b (caddr b))
            (define c-b (cadddr b))

            (or (< dist-a dist-b)
                (and (= dist-a dist-b)
                     (or (< price-a price-b)
                         (and (= price-a price-b)
                              (or (< r-a r-b)
                                  (and (= r-a r-b)
                                       (< c-a c-b))))))))))

  (take (map (lambda (item) (list (caddr item) (cadddr item)))
             sorted-items)
        k))