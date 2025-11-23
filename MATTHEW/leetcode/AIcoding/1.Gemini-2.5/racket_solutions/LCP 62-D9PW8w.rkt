(define (traffic-hub n roads)
  ;; Initialize in-degree and out-degree vectors for n intersections.
  ;; Each element is initially 0.
  (define in-degrees (make-vector n 0))
  (define out-degrees (make-vector n 0))

  ;; Iterate through each road to populate in-degrees and out-degrees.
  ;; For a road [fromi, toi], it means a directed road from fromi to toi.
  (for-each (lambda (road)
              (define from (car road))
              (define to (cadr road))
              ;; Increment out-degree for the 'from' intersection
              (vector-set! out-degrees from (+ (vector-ref out-degrees from) 1))
              ;; Increment in-degree for the 'to' intersection
              (vector-set! in-degrees to (+ (vector-ref in-degrees to) 1)))
            roads)

  ;; Check each intersection to see if it qualifies as a traffic hub.
  ;; A hub must have an in-degree of (n-1) and an out-degree of 0.
  (let loop ((i 0))
    (cond
      ;; If all intersections have been checked and no hub is found, return -1.
      ((= i n) -1)
      ;; Check if the current intersection 'i' is a hub.
      ;; Condition 1: All other (n-1) intersections have a road to 'i'.
      ;; Condition 2: 'i' has no road to any other intersection.
      ((and (= (vector-ref in-degrees i) (- n 1))
            (= (vector-ref out-degrees i) 0))
       i)
      ;; If 'i' is not a hub, continue checking the next intersection.
      (else (loop (+ i 1))))))