#lang racket

(define (bricks-falling-when-hit grid-list hits-list)
  (define rows (length grid-list))
  (define cols (length (car grid-list)))

  (define grid (list->vector (map list->vector grid-list)))
  (define hits (list->vector (map list->vector hits-list)))

  (define num-nodes (+ (* rows cols) 1))
  (define ceiling-node (- num-nodes 1))

  (define parent (make-vector num-nodes 0))
  (define set-size (make-vector num-nodes 0))

  (for ([i (in-range num-nodes)])
    (vector-set! parent i i))

  (define (find i)
    (let ((p (vector-ref parent i)))
      (if (= p i)
          i
          (let ((root (find p)))
            (vector-set! parent i root)
            root))))

  (define (union-sets i j)
    (let ((root-i (find i))
          (root-j (find j)))
      (unless (= root-i root-j)
        (let* ((size-root-i (vector-ref set-size root-i))
               (size-root-j (vector-ref set-size root-j)))
          (cond
            ((= root-i ceiling-node)
             (vector-set! parent root-j root-i)
             (vector-set! set-size root-i (+ size-root-i size-root-j)))
            ((= root-j ceiling-node)
             (vector-set! parent root-i root-j)
             (vector-set! set-size root-j (+ size-root-i size-root-j)))
            ((>= size-root-i size-root-j)
             (vector-set! parent root-j root-i)
             (vector-set! set-size root-i (+ size-root-i size-root-j)))
            (else
             (vector-set! parent root-i root-j)
             (vector-set! set-size root-j (+ size-root-i size-root-j))))))))

  (define mutable-grid (list->vector (map list->vector (vector->list grid))))
  (define original-grid (list->vector (map list->vector (vector->list grid))))

  (for ([k (in-range (vector-length hits))])
    (let* ((hit (vector-ref hits k))
           (r (vector-ref hit 0))
           (c (vector-ref hit 1)))
      (vector-set! (vector-ref mutable-grid r) c 0)))

  (for ([r (in-range rows)])
    (for ([c (in-range cols)])
      (when (= (vector-ref (vector-ref mutable-grid r) c) 1)
        (let ((idx (+ (* r cols) c)))
          (vector-set! set-size idx 1)
          (when (= r 0)
            (union-sets idx ceiling-node))

          (define drs '(-1 0))
          (define dcs '(0 -1))
          (for ([k (in-range (length drs))])
            (let* ((nr (+ r (list-ref drs k)))
                   (nc (+ c (list-ref dcs k))))
              (when (and (>= nr 0) (< nr rows)
                         (>= nc 0) (< nc cols)
                         (= (vector-ref (vector-ref mutable-grid nr) nc) 1))
                (union-sets idx (+ (* nr cols) nc))))))))

  (define results (make-vector (vector-length hits) 0))

  (for ([k (in-range (- (vector-length hits) 1) -1 -1)])
    (let* ((hit (vector-ref hits k))
           (hr (vector-ref hit 0))
           (hc (vector-ref hit 1)))

      (when (= (vector-ref (vector-ref original-grid hr) hc) 1)
        (let ((stable-bricks-before (vector-ref set-size (find ceiling-node))))

          (vector-set! (vector-ref mutable-grid hr) hc 1)
          (let ((current-idx (+ (* hr cols) hc)))
            (vector-set! set-size current-idx 1)

            (when (= hr 0)
              (union-sets current-idx ceiling-node))

            (define drs '(-1 1 0 0))
            (define dcs '(0 0 -1 1))
            (for ([j (in-range (length drs))])
              (let* ((nr (+ hr (list-ref drs j)))
                     (nc (+ hc (list-ref dcs j))))
                (when (and (>= nr 0) (< nr rows)
                           (>= nc 0) (< nc cols)
                           (= (vector-ref (vector-ref mutable-grid nr) nc) 1))
                  (union-sets current-idx (+ (* nr cols) nc))))))

          (let ((stable-bricks-after (vector-ref set-size (find ceiling-node))))
            (vector-set! results k (max 0 (- stable-bricks-after stable-bricks-before 1)))))))

  (vector->list results))