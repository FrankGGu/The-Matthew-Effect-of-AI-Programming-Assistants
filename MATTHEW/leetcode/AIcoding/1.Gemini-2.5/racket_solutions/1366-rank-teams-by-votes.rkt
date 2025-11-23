#lang racket

(define (rank-teams votes)
  (cond
    [(empty? votes) ""]
    [else
     (define first-vote (car votes))
     (define num-ranks (string-length first-vote))
     (define team-counts (make-hash))

     (for ([i (in-range num-ranks)])
       (define team (string-ref first-vote i))
       (hash-set! team-counts team (make-vector num-ranks 0)))

     (for ([vote-str votes])
       (for ([i (in-range num-ranks)])
         (define team (string-ref vote-str i))
         (define team-vec (hash-ref team-counts team))
         (vector-set! team-vec i (+ (vector-ref team-vec i) 1))))

     (define all-teams (string->list first-vote))

     (define (compare-teams team1 team2)
       (define counts1 (hash-ref team-counts team1))
       (define counts2 (hash-ref team-counts team2))

       (let loop ([i 0])
         (cond
           [(= i num-ranks)
            (char<? team1 team2)]
           [else
            (define c1 (vector-ref counts1 i))
            (define c2 (vector-ref counts2 i))
            (cond
              [(> c1 c2) #t]
              [(< c1 c2) #f]
              [else (loop (+ i 1))])])))

     (define sorted-teams (sort all-teams compare-teams))

     (list->string sorted-teams)]))