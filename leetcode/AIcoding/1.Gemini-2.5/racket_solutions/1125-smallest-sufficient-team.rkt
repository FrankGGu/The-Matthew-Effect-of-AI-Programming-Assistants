#lang racket

(define (smallest-sufficient-team req-skills people)
  (define num-req-skills (length req-skills))
  (define num-people (length people))

  ;; 1. Map skills to integers for bitmask representation
  (define skill-to-int-map (make-hash))
  (for ([s req-skills] [i (in-naturals)])
    (hash-set! skill-to-int-map s i))

  ;; 2. Convert each person's skills into a bitmask
  (define people-masks
    (for/list ([person-skills people])
      (for/fold ([mask 0]) ([skill person-skills])
        (if (hash-has-key? skill-to-int-map skill)
            (bitwise-ior mask (arithmetic-shift 1 (hash-ref skill-to-int-map skill)))
            mask))))

  ;; Define the target mask where all required skills are covered
  (define target-all-skills (sub1 (arithmetic-shift 1 num-req-skills)))

  ;; Initialize +infinity for DP values (a number larger than any possible team size)
  (define +infinity (add1 num-people)) 

  ;; dp[mask] stores the minimum number of people required to cover 'mask' skills
  (define dp (make-vector (add1 target-all-skills) +infinity))
  ;; parent[mask] stores a pair (prev_mask . person_idx) to reconstruct the team
  (define parent (make-vector (add1 target-all-skills) #f))

  ;; Base case: 0 people are needed to cover 0 skills
  (vector-set! dp 0 0)

  ;; 3. Iterate through all possible skill masks and people to update DP
  (for ([mask (in-range (add1 target-all-skills))])
    (when (< (vector-ref dp mask) +infinity) ; Only consider reachable masks
      (for ([p-idx (in-range num-people)])
        (define p-skills-mask (list-ref people-masks p-idx))
        (define new-mask (bitwise-ior mask p-skills-mask))

        ;; If adding this person results in a smaller team for new-mask
        (when (< (+ (vector-ref dp mask) 1) (vector-ref dp new-mask))
          (vector-set! dp new-mask (+ (vector-ref dp mask) 1))
          (vector-set! parent new-mask (cons mask p-idx))))))

  ;; 4. Reconstruct the team by backtracking using the parent array
  (define result-team '())
  (define current-mask target-all-skills)

  (while (> current-mask 0)
    (define entry (vector-ref parent current-mask))
    (define prev-mask (car entry))
    (define person-idx (cdr entry))
    (set! result-team (cons person-idx result-team)) ; Add person to the team
    (set! current-mask prev-mask)) ; Move to the previous mask

  result-team)