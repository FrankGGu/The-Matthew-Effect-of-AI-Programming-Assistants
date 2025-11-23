(define (closest-room rooms queries)
  (define n (length rooms))
  (define room-map (map (lambda (x) (list (car x) (cdr x))) rooms))
  (define room-size (map (lambda (x) (cdr x)) rooms))
  (define sorted-queries (sort (map-indexed (lambda (i q) (list (car q) (cdr q) i)) queries) 
                                             (lambda (a b) (<= (car a) (car b))))))

  (define (find-closest-room query)
    (define (valid-room? room)
      (and (<= (cdr query) (cdr room))
           (not (null? (filter (lambda (x) (>= (cdr x) (car query))) room-size)))))
    (define valid-rooms (filter valid-room? room-map))
    (if (null? valid-rooms)
        -1
        (define closest (apply max (map car valid-rooms)))
        closest))

  (map find-closest-room sorted-queries))