#lang racket

(struct magic-dict (build-dict-proc search-proc) #:transparent)

(define (magic-dictionary)
  (let ([dict '()]) ; Internal state: list of words

    (define (build-dict! word-list)
      (set! dict word-list)) ; Update the internal dictionary

    (define (search search-word)
      (let ([search-len (string-length search-word)])
        (let loop ([words dict])
          (cond
            [(empty? words) #f] ; No match found in the dictionary
            [else
             (let* ([current-word (car words)]
                    [current-len (string-length current-word)])
               (if (= search-len current-len)
                   ; Check if current-word is a "magic" match for search-word
                   (let ([diff-count 0])
                     (for ([i (in-range search-len)])
                       (when (not (char=? (string-ref search-word i) (string-ref current-word i)))
                         (set! diff-count (+ diff-count 1))))

                     (if (= diff-count 1)
                         #t ; Found a match with exactly one difference
                         (loop (cdr words)))) ; Continue searching in the rest of the dictionary
                   (loop (cdr words))))]))) ; Lengths don't match, continue searching

    ; Return an instance of the struct containing the methods
    (magic-dict build-dict! search)))