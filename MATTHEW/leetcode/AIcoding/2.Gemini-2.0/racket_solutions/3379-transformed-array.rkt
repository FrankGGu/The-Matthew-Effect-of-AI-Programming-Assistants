(provide transform-array)

(define transform-array
  (contract
   (-> (listof exact-integer?) (exact-integer? . -> . exact-integer?) exact-integer?)
   (lambda (arr func)
     (let loop ([new-arr arr])
       (let* ([transformed-arr (map (lambda (i) (if (or (= i 0) (= i (- (length new-arr) 1)))
                                                      (list-ref new-arr i)
                                                      (func (list-ref new-arr (- i 1)) (list-ref new-arr i) (list-ref new-arr (+ i 1)))))
                                    (range 0 (length new-arr)))]
              [updated-arr (list->vector transformed-arr)]
              [original-arr (list->vector new-arr)]
              [same? (for/and ([i (in-range (length new-arr))])
                       (= (vector-ref updated-arr i) (vector-ref original-arr i)))]
              [transformed-list (vector->list updated-arr)])

         (if same?
             transformed-list
             (loop transformed-list)))))))