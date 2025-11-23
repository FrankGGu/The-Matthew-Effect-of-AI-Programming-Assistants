(require racket/set)

(define (count-complete-subarrays nums)
  (let* ([n (length nums)]
         [all-distinct-elements (list->set nums)]
         [k (set-count all-distinct-elements)]
         [complete-subarrays-count 0])

    (for ([i (in-range n)])
      (let ([current-distinct-elements (set)])
        (for ([j (in-range i n)])
          (set! current-distinct-elements (set-add current-distinct-elements (list-ref nums j)))
          (when (= (set-count current-distinct-elements) k)
            (set! complete-subarrays-count (+ complete-subarrays-count 1))))))
    complete-subarrays-count))