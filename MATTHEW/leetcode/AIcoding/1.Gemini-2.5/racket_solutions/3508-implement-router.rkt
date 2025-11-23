#lang racket
(require racket/string)
(require racket/hash)

(struct route-entry (parsed-path handler) #:transparent)

(define (Router)
  (define current-routes (box '()))

  (define (parse-path path-string)
    (filter (lambda (seg) (not (string=? seg "")))
            (string-split path-string "/")))

  (define (match-segments registered-segments current-incoming-segments)
    (cond
      ((and (empty? registered-segments) (empty? current-incoming-segments))
       (hash))
      ((or (empty? registered-segments) (empty? current-incoming-segments))
       #f)
      (else
       (define reg-seg (first registered-segments))
       (define inc-seg (first current-incoming-segments))
       (cond
         ((and (string? reg-seg) (string-starts-with? reg-seg ":"))
          (define param-name (substring reg-seg 1))
          (define rest-match (match-segments (rest registered-segments) (rest current-incoming-segments)))
          (and rest-match
               (hash-set rest-match (string->symbol param-name) inc-seg)))
         ((string=? reg-seg inc-seg)
          (match-segments (rest registered-segments) (rest current-incoming-segments)))
         (else
          #f))))))

  (define (register-route path-string handler-fn)
    (define parsed-path (parse-path path-string))
    (define new-entry (route-entry parsed-path handler-fn))
    (set-box! current-routes (append (unbox current-routes) (list new-entry))))

  (define (dispatch-route path-string)
    (define incoming-segments (parse-path path-string))
    (for ([entry (unbox current-routes)])
      (define registered-path (route-entry-parsed-path entry))
      (define handler-fn (route-entry-handler entry))
      (define params (match-segments registered-path incoming-segments))
      (when params
        (call-with-current-continuation
         (lambda (k)
           (k (handler-fn params))))))
    #f)

  (struct router-instance (register! dispatch) #:transparent)
  (router-instance register-route dispatch-route))