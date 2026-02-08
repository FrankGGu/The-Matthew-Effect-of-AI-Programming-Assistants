(define (predict-party-victory senate)
  (let loop ([r-queue '()] [d-queue '()] [senate (string->list senate)])
    (cond
      [(null? senate)
       (if (null? r-queue) "Dire" "Radiant")]
      [(eq? (car senate) #\R)
       (if (null? d-queue)
           (loop (append r-queue (list 'R)) d-queue (cdr senate))
           (loop r-queue (cdr d-queue) (cdr senate)))]
      [else
       (if (null? r-queue)
           (loop r-queue (append d-queue (list 'D)) (cdr senate))
           (loop (cdr r-queue) d-queue (cdr senate)))])))