(define (count-vowel-permutations n)
  (define MOD 1000000007)

  (if (= n 1)
      5
      (let loop ((k 1)
                 (a_count 1)
                 (e_count 1)
                 (i_count 1)
                 (o_count 1)
                 (u_count 1))
        (if (= k n)
            (modulo (+ a_count e_count i_count o_count u_count) MOD)
            (let ((next_a_count (modulo (+ e_count i_count u_count) MOD))
                  (next_e_count (modulo (+ a_count i_count) MOD))
                  (next_i_count (modulo (+ e_count o_count) MOD))
                  (next_o_count (modulo i_count MOD))
                  (next_u_count (modulo (+ i_count o_count) MOD)))
              (loop (+ k 1)
                    next_a_count
                    next_e_count
                    next_i_count
                    next_o_count
                    next_u_count))))))