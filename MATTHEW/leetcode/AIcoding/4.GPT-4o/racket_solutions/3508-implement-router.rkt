(struct Route (path handler))
(struct Router (routes))

(define (createRouter)
  (Router '()))

(define (addRoute router path handler)
  (let ((new-route (Route path handler)))
    (Router (cons new-route (Router-routes router)))))

(define (findHandler router path)
  (define (match route path)
    (let ((route-path (Route-path route)))
      (and (string-prefix? route-path path)
           (string? (Route-handler route)))))
  (define (search routes)
    (cond
      ((null? routes) #f)
      ((match (car routes) path) (Route-handler (car routes)))
      (else (search (cdr routes)))))
  (search (Router-routes router)))

(define (handleRequest router path)
  (let ((handler (findHandler router path)))
    (if handler
        (handler)
        (lambda () "404 Not Found"))))

(define (setHandler router path handler)
  (let ((existing-handler (findHandler router path)))
    (if existing-handler
        (addRoute router path handler)
        (addRoute router path handler))))