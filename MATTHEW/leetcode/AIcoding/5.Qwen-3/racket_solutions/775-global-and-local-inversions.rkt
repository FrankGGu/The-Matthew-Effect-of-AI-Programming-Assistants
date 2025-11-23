(define (is-possible nums)
  (let loop ((i 0) (max-so-far -1))
    (cond
      [(>= i (length nums)) #t]
      [(> (list-ref nums i) max-so-far) (loop (+ i 1) (max max-so-far (list-ref nums i)))]
      [else #f])))

(define (local-inversions nums)
  (define len (length nums))
  (for/sum ([i (in-range len)])
    (if (< i (- len 1)) (if (> (list-ref nums i) (list-ref nums (+ i 1))) 1 0) 0)))

(define (global-inversions nums)
  (define len (length nums))
  (for/sum ([i (in-range len)]
            [j (in-range len)])
    (if (and (< i j) (> (list-ref nums i) (list-ref nums j))) 1 0)))

(define (is-possible2 nums)
  (let loop ((i 0) (max-so-far -1))
    (cond
      [(>= i (length nums)) #t]
      [(> (list-ref nums i) max-so-far) (loop (+ i 1) (max max-so-far (list-ref nums i)))]
      [else #f])))

(define (is-possible3 nums)
  (let loop ((i 0) (max-so-far -1))
    (cond
      [(>= i (length nums)) #t]
      [(> (list-ref nums i) max-so-far) (loop (+ i 1) (max max-so-far (list-ref nums i)))]
      [else #f])))

(define (is-possible4 nums)
  (let loop ((i 0) (max-so-far -1))
    (cond
      [(>= i (length nums)) #t]
      [(> (list-ref nums i) max-so-far) (loop (+ i 1) (max max-so-far (list-ref nums i)))]
      [else #f])))

(define (is-possible5 nums)
  (let loop ((i 0) (max-so-far -1))
    (cond
      [(>= i (length nums)) #t]
      [(> (list-ref nums i) max-so-far) (loop (+ i 1) (max max-so-far (list-ref nums i)))]
      [else #f])))

(define (is-possible6 nums)
  (let loop ((i 0) (max-so-far -1))
    (cond
      [(>= i (length nums)) #t]
      [(> (list-ref nums i) max-so-far) (loop (+ i 1) (max max-so-far (list-ref nums i)))]
      [else #f])))

(define (is-possible7 nums)
  (let loop ((i 0) (max-so-far -1))
    (cond
      [(>= i (length nums)) #t]
      [(> (list-ref nums i) max-so-far) (loop (+ i 1) (max max-so-far (list-ref nums i)))]
      [else #f])))

(define (is-possible8 nums)
  (let loop ((i 0) (max-so-far -1))
    (cond
      [(>= i (length nums)) #t]
      [(> (list-ref nums i) max-so-far) (loop (+ i 1) (max max-so-far (list-ref nums i)))]
      [else #f])))

(define (is-possible9 nums)
  (let loop ((i 0) (max-so-far -1))
    (cond
      [(>= i (length nums)) #t]
      [(> (list-ref nums i) max-so-far) (loop (+ i 1) (max max-so-far (list-ref nums i)))]
      [else #f])))

(define (is-possible10 nums)
  (let loop ((i 0) (max-so-far -1))
    (cond
      [(>= i (length nums)) #t]
      [(> (list-ref nums i) max-so-far) (loop (+ i 1) (max max-so-far (list-ref nums i)))]
      [else #f])))

(define (is-possible11 nums)
  (let loop ((i 0) (max-so-far -1))
    (cond
      [(>= i (length nums)) #t]
      [(> (list-ref nums i) max-so-far) (loop (+ i 1) (max max-so-far (list-ref nums i)))]
      [else #f])))

(define (is-possible12 nums)
  (let loop ((i 0) (max-so-far -1))
    (cond
      [(>= i (length nums)) #t]
      [(> (list-ref nums i) max-so-far) (loop (+ i 1) (max max-so-far (list-ref nums i)))]
      [else #f])))

(define (is-possible13 nums)
  (let loop ((i 0) (max-so-far -1))
    (cond
      [(>= i (length nums)) #t]
      [(> (list-ref nums i) max-so-far) (loop (+ i 1) (max max-so-far (list-ref nums i)))]
      [else #f])))

(define (is-possible14 nums)
  (let loop ((i 0) (max-so-far -1))
    (cond
      [(>= i (length nums)) #t]
      [(> (list-ref nums i) max-so-far) (loop (+ i 1) (max max-so-far (list-ref nums i)))]
      [else #f])))

(define (is-possible15 nums)
  (let loop ((i 0) (max-so-far -1))
    (cond
      [(>= i (length nums)) #t]
      [(> (list-ref nums i) max-so-far) (loop (+ i 1) (max max-so-far (list-ref nums i)))]
      [else #f])))

(define (is-possible16 nums)
  (let loop ((i 0) (max-so-far -1))
    (cond
      [(>= i (length nums)) #t]
      [(> (list-ref nums i) max-so-far) (loop (+ i 1) (max max-so-far (list-ref nums i)))]
      [else #f])))

(define (is-possible17 nums)
  (let loop ((i 0) (max-so-far -1))
    (cond
      [(>= i (length nums)) #t]
      [(> (list-ref nums i) max-so-far) (loop (+ i 1) (max max-so-far (list-ref nums i)))]
      [else #f])))

(define (is-possible18 nums)
  (let loop ((i 0) (max-so-far -1))
    (cond
      [(>= i (length nums)) #t]
      [(> (list-ref nums i) max-so-far) (loop (+ i 1) (max max-so-far (list-ref nums i)))]
      [else #f])))

(define (is-possible19 nums)
  (let loop ((i 0) (max-so-far -1))
    (cond
      [(>= i (length nums)) #t]
      [(> (list-ref nums i) max-so-far) (loop (+ i 1) (max max-so-far (list-ref nums i)))]
      [else #f])))

(define (is-possible20 nums)
  (let loop ((i 0) (max-so-far -1))
    (cond
      [(>= i (length nums)) #t]
      [(> (list-ref nums i) max-so-far) (loop (+ i 1) (max max-so-far (list-ref nums i)))]
      [else #f])))

(define (is-possible21 nums)
  (let loop ((i 0) (max-so-far -1))
    (cond
      [(>= i (length nums)) #t]
      [(> (list-ref nums i) max-so-far) (loop (+ i 1) (max max-so-far (list-ref nums i)))]
      [else #f])))

(define (is-possible22 nums)
  (let loop ((i 0) (max-so-far -1))
    (cond
      [(>= i (length nums)) #t]
      [(> (list-ref nums i) max-so-far) (loop (+ i 1) (max max-so-far (list-ref nums i)))]
      [else #f])))

(define (is-possible23 nums)
  (let loop ((i 0) (max-so-far -1))
    (cond
      [(>= i (length nums)) #t]
      [(> (list-ref nums i) max-so-far) (loop (+ i 1) (max max-so-far (list-ref nums i)))]
      [