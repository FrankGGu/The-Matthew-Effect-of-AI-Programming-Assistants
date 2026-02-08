#lang racket

(define (minimum-cost-to-convert-string source target original changed cost)
  (define num-chars 26)
  (define infinity (expt 10 18)) ; A sufficiently large number for infinity

  ; Initialize the adjacency matrix using a vector of vectors
  ; min-costs[i][j] stores the minimum cost to change char i to char j
  (define min-costs
    (build-vector num-chars
                  (lambda (i)
                    (build-vector num-chars
                                  (lambda (j)
                                    (if (= i j) 0 infinity))))))

  ; Populate initial costs from original, changed, cost arrays
  (for ([orig-char (in-list original)]
        [chan-char (in-list changed)]
        [c (in-list cost)])
    (define orig-idx (- (char->integer orig-char) (char->integer #\a)))
    (define chan-idx (- (char->integer chan-char) (char->integer #\a)))
    (vector-set! (vector-ref min-costs orig-idx) chan-idx
                 (min (vector-ref (vector-ref min-costs orig-idx) chan-idx) c)))

  ; Apply Floyd-Warshall algorithm
  (for ([k (in-range num-chars)])
    (for ([i (in-range num-chars)])
      (for ([j (in-range num-chars)])
        (define cost-ik (vector-ref (vector-ref min-costs i) k))
        (define cost-kj (vector-ref (vector-ref min-costs k) j))

        ; Only consider path through k if both segments are reachable
        (when (and (< cost-ik infinity) (< cost-kj infinity))
          (define path-through-k (+ cost-ik cost-kj))
          (when (< path-through-k (vector-ref (vector-ref min-costs i) j))
            (vector-set! (vector-ref min-costs i) j path-through-k))))))

  ; Calculate total cost for converting source to target
  (let ([total-conversion-cost 0])
    (for ([idx (in-range (string-length source))])
      (define s-char (string-ref source idx))
      (define t-char (string-ref target idx))

      (unless (char=? s-char t-char)
        (define s-idx (- (char->integer s-char) (char->integer #\a)))
        (define t-idx (- (char->integer t-char) (char->integer #\a)))
        (define conversion-cost (vector-ref (vector-ref min-costs s-idx) t-idx))

        (when (= conversion-cost infinity)
          (set! total-conversion-cost -1)
          (break)) ; Exit the for loop if an impossible conversion is found

        (set! total-conversion-cost (+ total-conversion-cost conversion-cost))))
    total-conversion-cost))