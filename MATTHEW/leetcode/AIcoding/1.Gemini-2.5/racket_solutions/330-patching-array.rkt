(define (min-patches nums n)
  (let loop ((current-nums nums)
             (miss 1)
             (patches 0))
    (if (> miss n)
        patches
        (if (and (not (empty? current-nums))
                 (<= (car current-nums) miss))
            (loop (cdr current-nums)
                  (+ miss (car current-nums))
                  patches)
            (loop current-nums
                  (* miss 2)
                  (+ patches 1))))))