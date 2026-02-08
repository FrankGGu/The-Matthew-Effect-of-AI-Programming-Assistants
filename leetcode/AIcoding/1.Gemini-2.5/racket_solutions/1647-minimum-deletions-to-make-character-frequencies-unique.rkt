#lang racket
(require racket/set)

(define (min-deletions s)
  (define char-counts (make-hash))
  (for ([char (in-string s)])
    (hash-update! char-counts char (lambda (v) (+ v 1)) 0))

  (define frequencies (sort (hash-values char-counts) >))

  (let loop ((freqs frequencies)
             (seen-frequencies (set))
             (deletions 0))
    (if (empty? freqs)
        deletions
        (let* ((current-initial-freq (first freqs))
               (rest-freqs (rest freqs)))
          (let inner-loop ((current-freq current-initial-freq)
                           (current-deletions deletions))
            (if (> current-freq 0)
                (if (set-member? seen-frequencies current-freq)
                    (inner-loop (- current-freq 1) (+ current-deletions 1))
                    (loop rest-freqs (set-add seen-frequencies current-freq) current-deletions))
                (loop rest-freqs seen-frequencies current-deletions)))))))