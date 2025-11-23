(define (guess-era s)
  (cond [(string-contains? s "唐") "唐朝"]
        [(string-contains? s "宋") "宋朝"]
        [(string-contains? s "明") "明朝"]
        [(string-contains? s "清") "清朝"]
        [else "未知"]))