(define (word-ladder beginWord endWord wordList)
  (define word-set (set wordList))
  (define (one-char-diff? w1 w2)
    (= (count (filter (lambda (x) (not (equal? (string-ref w1 x) (string-ref w2 x)))) (range (string-length w1))) 1))

  (define (bfs queue visited)
    (if (null? queue)
      -1
      (let* ((current (car queue))
             (depth (car (cdr current)))
             (word (car (cdr (cdr current))))
             (next-words (filter (lambda (w) (and (set-member? word-set w)
                                                  (not (set-member? visited w))
                                                  (one-char-diff? word w))) wordList)))
        (for-each (lambda (w) (set-add! visited w) (enqueue! queue (list (+ depth 1) w)))
                  next-words)
        (if (member? endWord next-words)
          (+ depth 1)
          (bfs (cdr queue) visited)))))

  (define (enqueue! queue elem)
    (set! queue (append queue (list elem))))

  (define (set-member? s elem)
    (member elem s))

  (bfs (list (list 1 beginWord)) (set (list beginWord))))