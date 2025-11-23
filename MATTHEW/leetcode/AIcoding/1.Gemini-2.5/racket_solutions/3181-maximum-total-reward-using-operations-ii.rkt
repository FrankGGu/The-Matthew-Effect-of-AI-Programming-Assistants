(define (maximum-total-reward rewardValues)
  ;; Sort rewardValues in ascending order.
  ;; This ensures that when we consider a reward 'r', any 's' it's added to
  ;; was formed by strictly smaller previous rewards, satisfying the problem condition.
  (define sorted-rewards (sort rewardValues <))

  ;; 'dp' is an integer representing a bitset.
  ;; The k-th bit of 'dp' is set (1) if a total reward 'k' is achievable,
  ;; and unset (0) otherwise.
  ;; Initially, only a total reward of 0 is achievable.
  (define dp 1) ; Binary ...0001, meaning bit 0 is set.

  ;; Iterate through each reward value 'r' in the sorted list.
  (for-each (lambda (r)
              ;; Create a mask to select achievable sums 's' that are strictly less than 'r'.
              ;; (expt 2 r) calculates 2^r.
              ;; (sub1 (expt 2 r)) calculates 2^r - 1, which is a number with 'r' bits set (from 0 to r-1).
              ;; For example, if r=3, mask = 2^3 - 1 = 7 (binary 0111).
              (define mask (sub1 (expt 2 r)))

              ;; Update the 'dp' bitset:
              ;; 1. (bitwise-and dp mask): This operation isolates the bits in 'dp'
              ;;    that correspond to sums 's' where 's < r'.
              ;; 2. (arithmetic-shift ... r): This shifts the isolated bits left by 'r' positions.
              ;;    Effectively, if bit 's' was set (meaning sum 's' was achievable and 's < r'),
              ;;    it now sets bit 's + r'. This represents forming new sums by adding 'r'.
              ;; 3. (bitwise-ior dp ...): This combines the newly formed sums (from step 2)
              ;;    with the existing achievable sums in 'dp'.
              (set! dp (bitwise-ior dp (arithmetic-shift (bitwise-and dp mask) r))))
            sorted-rewards)

  ;; After processing all rewards, 'dp' contains all achievable sums.
  ;; We need to find the maximum achievable reward, which corresponds to the index
  ;; of the highest set bit in 'dp'.
  ;; (integer-length dp) returns 1 + (index of the highest set bit).
  ;; For example, if dp = 63 (binary 111111), integer-length is 6,
  ;; meaning the highest set bit is at index 5.
  (define max-possible-bit-index (sub1 (integer-length dp)))

  ;; Iterate downwards from the highest possible bit index to find the first (highest) set bit.
  (let loop ((k max-possible-bit-index))
    (if (< k 0)
        ;; This case should ideally not be reached, as sum 0 is always achievable,
        ;; meaning bit 0 of dp is always set.
        0
        (if (bitwise-bit-set? dp k)
            ;; If the k-th bit is set, then 'k' is an achievable sum,
            ;; and since we are iterating downwards, it is the maximum such sum.
            k
            ;; Otherwise, check the next lower bit.
            (loop (sub1 k)))))
  )