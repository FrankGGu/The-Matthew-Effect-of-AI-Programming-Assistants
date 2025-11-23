(require racket/list)

(define (video-stitching clips T)
  (define sorted-clips
    (sort clips
          (lambda (c1 c2)
            (or (< (car c1) (car c2))
                (and (= (car c1) (car c2))
                     (< (cadr c1) (cadr c2)))))))

  (let loop ((num-clips 0)
             (current-end 0)
             (clips-to-process sorted-clips))
    (cond
      ((>= current-end T) num-clips)
      (else
       (let inner-loop ((remaining-clips clips-to-process)
                        (temp-farthest-reach current-end))
         (cond
           ((empty? remaining-clips)
            (if (= temp-farthest-reach current-end)
                -1
                (loop (+ num-clips 1) temp-farthest-reach '())))
           ((> (car (car remaining-clips)) current-end)
            (if (= temp-farthest-reach current-end)
                -1
                (loop (+ num-clips 1) temp-farthest-reach remaining-clips)))
           (else
            (inner-loop (cdr remaining-clips)
                        (max temp-farthest-reach (cadr (car remaining-clips)))))))))))