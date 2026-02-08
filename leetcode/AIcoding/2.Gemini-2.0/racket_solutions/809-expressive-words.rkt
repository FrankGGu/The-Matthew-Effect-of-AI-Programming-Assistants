(define (expressive-words s words)
  (define (group-string str)
    (let loop ([str str] [groups '()] [curr-char #f] [curr-count 0])
      (cond
        [(empty? str)
         (if (eq? curr-char #f)
             (reverse groups)
             (reverse (cons (list curr-char curr-count) groups)))]
        [else
         (let ([first-char (string-ref str 0)])
           (if (eq? first-char curr-char)
               (loop (substring str 1) groups curr-char (+ curr-count 1))
               (if (eq? curr-char #f)
                   (loop (substring str 1) groups first-char 1)
                   (loop (substring str 1) (cons (list curr-char curr-count) groups) first-char 1)))))])))

  (define (is-stretchy? s-groups word-groups)
    (cond
      [(or (null? s-groups) (null? word-groups))
       (equal? s-groups word-groups)]
      [else
       (let ([s-group (car s-groups)]
             [word-group (car word-groups)])
         (let ([s-char (car s-group)]
               [s-count (cadr s-group)]
               [word-char (car word-group)]
               [word-count (cadr word-group)])
           (if (not (eq? s-char word-char))
               #f
               (cond
                 [(equal? s-count word-count)
                  (is-stretchy? (cdr s-groups) (cdr word-groups))]
                 [(and (> s-count word-count) (>= s-count 3))
                  (is-stretchy? (cdr s-groups) (cdr word-groups))]
                 [else
                  #f]))))]))

  (let ([s-groups (group-string s)])
    (length (filter (lambda (word) (is-stretchy? s-groups (group-string word))) words))))