(define (getMaxGridHappiness m n emptySeats a b)
  (define (dp i j k l happiness)
    (if (= i m)
        happiness
        (let* ((next-i (if (= j (- n 1)) (+ i 1) i))
               (next-j (if (= j (- n 1)) 0 (+ j 1)))
               (happiness-with-person (if (> k 0) (+ happiness a) happiness))
               (happiness-without-person (dp next-i next-j k l happiness))
               (happiness-with-person-and-no-people (if (> l 0)
                                                         (dp next-i next-j k (- l 1) (+ happiness b))
                                                         happiness-without-person))
               (happiness-with-person-and-people (if (> k 0)
                                                      (dp next-i next-j (- k 1) l happiness-with-person)
                                                      happiness-without-person)))
          (max happiness-without-person
               happiness-with-person-and-no-people
               happiness-with-person-and-people))))
  (dp 0 0 emptySeats emptySeats 0))

(define (maximizeGridHappiness m n emptySeats a b)
  (getMaxGridHappiness m n emptySeats a b))