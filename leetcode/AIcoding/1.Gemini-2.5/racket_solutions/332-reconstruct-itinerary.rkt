(define (find-itinerary tickets)
  (define graph (make-hash)) ; adjacency list: airport -> sorted list of destinations
  (define path '()) ; result path, built in reverse order of processing

  ;; Build the graph
  (for-each
   (lambda (ticket)
     (define from (car ticket))
     (define to (cadr ticket))
     (hash-set! graph from (cons to (hash-ref graph from '()))))
   tickets)

  ;; Sort destinations for lexicographical order
  (for-each
   (lambda (key val)
     (hash-set! graph key (sort val string<?)))
   (hash-keys graph))

  ;; DFS function to find the Eulerian path
  (define (dfs airport)
    (let loop ()
      (define destinations (hash-ref graph airport '()))
      (when (not (empty? destinations))
        (define next-airport (car destinations))
        ;; "Consume" the ticket by removing it from the graph's list
        (hash-set! graph airport (cdr destinations))
        (dfs next-airport) ; Recurse on the next airport
        (loop))) ; Continue processing remaining tickets from the current airport
    ;; After all outgoing tickets from 'airport' have been used,
    ;; add 'airport' to the path.
    (set! path (cons airport path)))

  ;; Start DFS from "JFK" as per problem statement
  (dfs "JFK")

  ;; The path is built by prepending airports as they are fully explored.
  ;; This naturally results in the correct order for an Eulerian path.
  path)