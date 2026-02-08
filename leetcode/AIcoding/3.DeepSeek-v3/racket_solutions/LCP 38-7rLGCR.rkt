#lang racket

(define (guard-castle grid)
  (define m (length grid))
  (define n (if (zero? m) 0 (string-length (first grid))))
  (define dirs '((0 1) (1 0) (0 -1) (-1 0)))

  (define (bfs q visited)
    (if (null? q)
        visited
        (let* ((pos (car q))
               (i (car pos))
               (j (cdr pos))
               (rest-q (cdr q))
               (new-visited (cons pos visited)))
          (bfs 
           (append 
            rest-q 
            (filter 
             (lambda (d) 
               (let ((ni (+ i (car d)))
                     (nj (+ j (cdr d))))
                 (and (>= ni 0) (< ni m) (>= nj 0) (< nj n)
                      (not (member (cons ni nj) new-visited))
                      (let ((c (string-ref (list-ref grid ni) nj)))
                        (or (char=? c #\.) (char=? c #\P))))))
             dirs))
           new-visited))))

  (define (find-pos c)
    (for*/list ([i (in-range m)]
                [j (in-range n)]
                #:when (char=? (string-ref (list-ref grid i) j) c))
      (cons i j)))

  (define castle-pos (find-pos #\C))
  (define portal-pos (find-pos #\P))

  (if (null? castle-pos)
      0
      (let* ((start (car castle-pos))
             (visited (bfs (list start) '()))
             (reachable (filter (lambda (p) (member p visited)) portal-pos)))
        (if (null? reachable)
            -1
            (let ((min-dist (apply min (map (lambda (p) (+ (abs (- (car p) (car start))) (abs (- (cdr p) (cdr start))))) reachable))))
              min-dist)))))