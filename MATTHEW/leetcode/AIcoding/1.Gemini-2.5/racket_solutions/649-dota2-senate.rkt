(require data/queue)

(define (predict-party-victory senate)
  (let* ((n (string-length senate))
         (radiant-q (make-queue))
         (dire-q (make-queue)))
    (for ((i (range n)))
      (if (char=? (string-ref senate i) #\R)
          (enqueue! radiant-q i)
          (enqueue! dire-q i)))

    (let loop ()
      (cond
        ((queue-empty? radiant-q) "Dire")
        ((queue-empty? dire-q) "Radiant")
        (else
         (let* ((r-idx (dequeue! radiant-q))
                (d-idx (dequeue! dire-q)))
           (if (< r-idx d-idx)
               (enqueue! radiant-q (+ r-idx n))
               (enqueue! dire-q (+ d-idx n)))
           (loop))))))