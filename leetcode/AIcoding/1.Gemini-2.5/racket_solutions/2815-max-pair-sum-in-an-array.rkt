(define (max-pair-sum-in-an-array nums)
  ;; Helper function to get the maximum digit in a number
  (define (get-max-digit n)
    (if (= n 0)
        0
        (let loop ((num n) (max-d 0))
          (if (= num 0)
              max-d
              (loop (quotient num 10) (max max-d (remainder num 10)))))))

  (define digit-groups (make-hash))
  (define max-overall-sum -1)

  ;; Group numbers by their maximum digit
  (for-each (lambda (num)
              (define md (get-max-digit num))
              (hash-set! digit-groups md (cons num (hash-ref digit-groups md '()))))
            nums)

  ;; Iterate through the groups and find the maximum sum of two largest numbers
  (hash-for-each
   digit-groups
   (lambda (md group-list)
     (when (>= (length group-list) 2)
       ;; Sort the list in descending order to easily pick the two largest
       (define sorted-group (sort group-list >))
       (define num1 (first sorted-group))
       (define num2 (second sorted-group))
       (set! max-overall-sum (max max-overall-sum (+ num1 num2)))))
   )

  max-overall-sum)