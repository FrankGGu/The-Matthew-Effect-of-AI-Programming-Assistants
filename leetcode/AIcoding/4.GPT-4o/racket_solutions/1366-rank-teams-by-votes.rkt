(define (rankTeams votes)
  (define (count-votes votes)
    (for/fold ([counts (make-hash)])
               ([vote votes])
      (for ([team (string->list vote)])
        (hash-update! counts team (lambda (x) (add1 x)) 0)))
    counts))

  (define (sort-teams counts)
    (define teams (hash-keys counts))
    (define sorted-teams
      (sort teams
            (lambda (a b)
              (let ([a-votes (hash-ref counts a)]
                    [b-votes (hash-ref counts b)])
                (or (> a-votes b-votes)
                    (and (= a-votes b-votes)
                         (string<? (string a) (string b))))))))
    sorted-teams)

  (define counts (count-votes votes))
  (define sorted-teams (sort-teams counts))
  (apply string-append sorted-teams))

(rankTeams '("ABC" "ACB" "CAB" "CBA" "BCA" "BAC"))