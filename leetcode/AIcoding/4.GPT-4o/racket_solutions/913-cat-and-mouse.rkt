(define (cat-and-mouse cats mice)
  (define (helper cat-a cat-b mouse)
    (cond
      [(= (abs (- cat-a mouse)) (abs (- cat-b mouse))) 0]
      [(< (abs (- cat-a mouse)) (abs (- cat-b mouse))) 1]
      [else -1]))
  (map (lambda (mouse)
         (helper (list-ref cats (car mouse)) 
                  (list-ref cats (cadr mouse)) 
                  (caddr mouse)))
       (map list (range (length cats)) (range (length cats)) (range (length mice)))))

(define (catAndMouse cats mice)
  (cat-and-mouse cats mice))