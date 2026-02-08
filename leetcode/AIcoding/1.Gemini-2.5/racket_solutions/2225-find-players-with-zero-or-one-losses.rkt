#lang racket

(require racket/hash)
(require racket/set)

(define (find-players-with-zero-or-one-losses matches)
  (define loss-counts (make-hash))
  (define all-players (set))

  (for-each (lambda (match)
              (define winner (car match))
              (define loser (cadr match))

              (set! all-players (set-add all-players winner))
              (set! all-players (set-add all-players loser))

              (hash-update! loss-counts loser (lambda (count) (+ count 1)) 0))
            matches)

  (define zero-loss-players-list '())
  (define one-loss-players-list '())

  (for-each (lambda (player)
              (define losses (hash-ref loss-counts player 0))
              (cond
                [(= losses 0)
                 (set! zero-loss-players-list (cons player zero-loss-players-list))]
                [(= losses 1)
                 (set! one-loss-players-list (cons player one-loss-players-list))]))
            (set->list all-players))

  (list (sort zero-loss-players-list <)
        (sort one-loss-players-list <)))