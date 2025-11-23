(define (master->guess master guess)
  (define (count-matches guess word)
    (let loop ([g (string->list guess)] [w (string->list word)] [acc 0])
      (cond
        [(empty? g) acc]
        [(= (car g) (car w)) (loop (cdr g) (cdr w) (+ acc 1))]
        [else (loop (cdr g) (cdr w) acc)])))
  (count-matches master guess))

(define (find-secret-word wordlist master)
  (let loop ([candidates wordlist] [num-guesses 0])
    (if (empty? candidates)
        #f
        (let* ([guess (list-ref candidates 0)]
               [match-count (master->guess master guess)])
          (if (= match-count 6)
              guess
              (let ([new-candidates (filter (lambda (word) (= (master->guess guess word) match-count)) candidates)])
                (loop new-candidates (+ num-guesses 1))))))))

(define (guess-the-word wordlist guess)
  (find-secret-word wordlist guess))