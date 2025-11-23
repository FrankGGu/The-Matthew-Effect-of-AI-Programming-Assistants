(define (min-moves-to-capture-the-queen rx ry bx by qx qy)
  (let* ([rook-can-capture-row?
          (and (= rx qx)
               (not (and (= bx rx)
                         (let ([min-y (min ry qy)]
                               [max-y (max ry qy)])
                           (and (> by min-y) (< by max-y))))))]
         [rook-can-capture-col?
          (and (= ry qy)
               (not (and (= by ry)
                         (let ([min-x (min rx qx)]
                               [max-x (max rx qx)])
                           (and (> bx min-x) (< bx max-x))))))]
         [rook-can-capture-directly?
          (or rook-can-capture-row? rook-can-capture-col?)]

         [bishop-on-same-diagonal?
          (= (abs (- qx bx)) (abs (- qy by)))]
         [bishop-blocked-diagonally?
          (and bishop-on-same-diagonal?
               (= (abs (- rx bx)) (abs (- ry by)))
               (let ([min-bx-qx (min bx qx)]
                     [max-bx-qx (max bx qx)]
                     [min-by-qy (min by qy)]
                     [max-by-qy (max by qy)])
                 (and (> rx min-bx-qx) (< rx max-bx-qx)
                      (> ry min-by-qy) (< ry max-by-qy))))]
         [bishop-can-capture-directly?
          (and bishop-on-same-diagonal? (not bishop-blocked-diagonally?))])

    (if (or rook-can-capture-directly? bishop-can-capture-directly?)
        1
        2)))