(define (find-ladders beginWord endWord wordList)
  (define word-set (set (append wordList (list beginWord))))
  (define (neighbors word)
    (filter (lambda (w)
              (if (= (string-length word) (string-length w))
                  (let loop ([i 0] [diff 0])
                    (cond
                      [(= i (string-length word)) (= diff 1)]
                      [(= (string-ref word i) (string-ref w i)) (loop (+ i 1) diff)]
                      [else (loop (+ i 1) (+ diff 1))]))
                  #f))
            wordList))

  (define (bfs)
    (let ([queue (list (list beginWord))]
          [visited (set (list beginWord))]
          [res '()])
      (let loop ([q queue] [level 1])
        (cond
          [(empty? q) res]
          [else
           (let* ([next-level '()]
                  [found-end #f]
                  [new-visited visited])
             (for ([path (in-list q)])
               (let ([last-word (last path)])
                 (for ([neighbor (in-list (filter (lambda (w) (set-member? w word-set)) (neighbors last-word)))])
                   (cond
                     [(set-member? neighbor visited) #f]
                     [else
                      (let ([new-path (append path (list neighbor))])
                        (cond
                          [(string=? neighbor endWord)
                           (set! found-end #t)
                           (set! res (append res (list new-path)))]
                          [else
                           (set! next-level (append next-level (list new-path)))
                           (set! new-visited (set-add new-visited neighbor))]))])))))
             (if found-end
                 res
                 (loop next-level new-visited)))))))
  (bfs))