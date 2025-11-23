(define (expressive-words S words)
  (define (is-stretchy s ws)
    (let loop ((s s) (ws ws) (count-s 1) (count-w 1))
      (cond
        ((null? s) (and (null? ws) (>= count-s 3))) 
        ((null? ws) (and (null? s) (>= count-s 3))) 
        ((char=? (car s) (car ws)) (loop (cdr s) (cdr ws) (+ count-s 1) count-w))
        ((char=? (car s) (car (cdr ws))) 
         (if (>= count-s 3) 
             (loop (cdr s) (cdr ws) (+ count-s 1) (+ count-w 1))
             #f))
        (else (and (>= count-s 3) (char=? (car s) (car ws)) (loop (cdr s) (cdr ws) 1 1))))))

  (define (count-expressive-words words)
    (length (filter (lambda (w) (is-stretchy S w)) words)))

  (count-expressive-words words))

(expressive-words "heeellooo" '("hello" "hi" "helo" "goodbye" "hillo"))