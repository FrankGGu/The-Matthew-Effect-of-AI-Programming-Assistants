(define (rank-teams-by-votes votes)
  (define num-teams (string-length (car votes)))
  (define team-rank-map (make-hash))

  (for ([team (string->list (car votes))])
    (hash-set! team-rank-map team (make-vector num-teams 0)))

  (for ([vote votes])
    (for/list ([team (in-string vote)]
               [i (in-range num-teams)])
      (vector-set! (hash-ref team-rank-map (string->list vote #:start i #:end (+ i 1)) '()) i (+ 1 (vector-ref (hash-ref team-rank-map (string->list vote #:start i #:end (+ i 1)) '()) i)))))

  (define sorted-teams
    (sort (string->list (car votes))
          (lambda (team1 team2)
            (let loop ([i 0])
              (cond
                [(= i num-teams) (char<? team1 team2)]
                [(> (vector-ref (hash-ref team-rank-map team1 '()) i) (vector-ref (hash-ref team-rank-map team2 '()) i)) #t]
                [(< (vector-ref (hash-ref team-rank-map team1 '()) i) (vector-ref (hash-ref team-rank-map team2 '()) i)) #f]
                [else (loop (+ i 1))]))))))

  (list->string sorted-teams))