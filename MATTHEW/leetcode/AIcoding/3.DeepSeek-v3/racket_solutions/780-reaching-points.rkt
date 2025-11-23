(define (reaching-points sx sy tx ty)
  (let loop ([tx tx] [ty ty])
    (cond
      [(and (= sx tx) (= sy ty)) #t]
      [(or (< tx sx) (< ty sy)) #f]
      [(> tx ty) (loop (- tx ty) ty)]
      [else (loop tx (- ty tx))])))