(define/contract (defang-ip-addr address)
  (-> string? string?)
  (regexp-replace* #rx"\\." address "[.]"))