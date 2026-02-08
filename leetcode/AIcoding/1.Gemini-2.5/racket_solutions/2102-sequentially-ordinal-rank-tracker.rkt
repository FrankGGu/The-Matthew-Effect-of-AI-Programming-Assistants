#lang racket
(require data/rbl-tree)

(define (city-compare city1 city2)
  (let ((score1 (car city1))
        (name1 (cdr city1))
        (score2 (car city2))
        (name2 (cdr city2)))
    (cond
      ;; Rule 1: Higher score is better
      ((> score1 score2) -1)
      ((< score1 score2) 1)
      (else
       ;; Rule 2: Scores are equal, compare names lexicographically
       (cond
         ((string<? name1 name2) -1)
         ((string>? name1 name2) 1)
         (else 0))))))

(struct SORTracker (cities-tree get-call-count) #:mutable)

(define (SORTracker-init)
  (SORTracker (rbl-tree-empty city-compare) 0))

(define (SORTracker-add this name score)
  (set-SORTracker-cities-tree! this
                               (rbl-tree-add (SORTracker-cities-tree this)
                                             (cons score name)
                                             (cons score name))))

(define (SORTracker-get this)
  ;; Increment the get call count
  (set-SORTracker-get-call-count! this (+ (SORTracker-get-call-count this) 1))
  ;; Retrieve the k-th best city, where k is the current get call count
  (let* ((k (SORTracker-get-call-count this))
         ;; rbl-tree-ref-kth returns (key . value)
         (city-pair (rbl-tree-ref-kth (SORTracker-cities-tree this) k)))
    ;; The value part of the city-pair is (score . name), we need the name (cdr)
    (cdr city-pair)))