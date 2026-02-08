#lang racket

(define-exn exn:fail:early-exit exn:fail?)

(define (string-transformation s t)
  (with-handlers
      ([exn:fail:early-exit? (lambda (exn) -1)])

    (define n (string-length s))
    (define char-to-char (make-hash))

    (for ([i (in-range n)])
      (define sc (string-ref s i))
      (define tc (string-ref t i))
      (cond
        [(hash-has-key? char-to-char sc)
         (when (not (char=? (hash-ref char-to-char sc) tc))
           (raise exn:fail:early-exit))]
        [else
         (hash-set! char-to-char sc tc)]))

    (define num-ops 0)
    (define visited (set))
    (define num-distinct-s-chars (hash-count char-to-char))

    (for-each
     (lambda (s-char)
       (when (not (set-member? visited s-char))
         (define current-node s-char)
         (define path-nodes (set))

         (define cycle-detected #f)
         (define loop-node #f)

         (let loop ()
           (when (and (hash-has-key? char-to-char current-node)
                      (not (set-member? visited current-node)))
             (set! visited (set-add visited current-node))
             (set! path-nodes (set-add path-nodes current-node))
             (set! current-node (hash-ref char-to-char current-node))
             (when (set-member? path-nodes current-node)
               (set! cycle-detected #t)
               (set! loop-node current-node))
             (unless cycle-detected (loop))))

         (when cycle-detected
           (define cycle-length 0)
           (define temp-node loop-node)
           (let cycle-len-loop ()
             (set! cycle-length (+ cycle-length 1))
             (set! temp-node (hash-ref char-to-char temp-node))
             (when (not (char=? temp-node loop-node))
               (cycle-len-loop)))

           (when (> cycle-length 1)
             (when (= num-distinct-s-chars 26)
               (raise exn:fail:early-exit))
             (set! num-ops (+ num-ops cycle-length 1))))

         (unless cycle-detected
           (for-each
            (lambda (node)
              (when (not (char=? node (hash-ref char-to-char node)))
                (set! num-ops (+ num-ops 1))))
            (set->list path-nodes)))))
     (hash-keys char-to-char))

    num-ops))