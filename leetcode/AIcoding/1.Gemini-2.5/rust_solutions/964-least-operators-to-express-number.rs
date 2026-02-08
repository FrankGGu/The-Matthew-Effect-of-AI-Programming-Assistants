use std::collections::HashMap;
use std::cmp::min;

struct Solution {
    x: i32,
    memo: HashMap<i32, i32>,
}

impl Solution {
    fn new(x_val: i32) -> Self {
        Solution {
            x: x_val,
            memo: HashMap::new(),
        }
    }

    fn dfs(&mut self, target: i32) -> i32 {
        if target == 0 {
            return 0;
        }
        if target == self.x {
            return 1;
        }
        // Base case for 1: x / x. The problem example implies this costs 2.
        // (1 for one 'x' usage, 1 for '/' operator)
        if target == 1 {
            return 2; 
        }

        if let Some(&cost) = self.memo.get(&target) {
            return cost;
        }

        let mut min_cost = i32::MAX;

        let mut k_idx = 0;
        let mut p_k: i64 = 1; // Use i64 for powers to prevent overflow

        // Find k_idx such that x^(k_idx) <= target
        // p_k will be the largest power of x that is less than or equal to target
        while let Some(next_p_k) = p_k.checked_mul(self.x as i64) {
            if next_p_k > target as i64 {
                break;
            }
            p_k = next_p_k;
            k_idx += 1;
        }

        // Calculate the cost to form x^k (p_k)
        // k_idx=0: x^0=1, cost 2 (for x/x)
        // k_idx=1: x^1=x, cost 1
        // k_idx>=2: x^k, cost 2*k_idx-1 (k_idx uses of x and k_idx-1 '*' operators)
        let cost_pk = if k_idx == 0 {
            2
        } else if k_idx == 1 {
            1
        } else {
            2 * k_idx - 1 
        };

        let q = target / (p_k as i32);
        let rem = target % (p_k as i32);

        // Option 1: target = q * p_k + rem
        // Cost for q * p_k: q uses of p_k and (q-1) '+' operators
        // Use i64 for intermediate calculations to prevent overflow, then cast to i32.
        let cost_q_pk_i64 = if q == 0 {
            0
        } else if q == 1 {
            cost_pk as i64
        } else {
            (q as i64) * (cost_pk as i64) + (q as i64 - 1)
        };

        let cost_q_pk = cost_q_pk_i64 as i32;

        if rem == 0 {
            min_cost = min(min_cost, cost_q_pk);
        } else {
            // Add 1 for the '+' operator between q*p_k and rem
            min_cost = min(min_cost, cost_q_pk + 1 + self.dfs(rem));
        }

        // Option 2: target = (q+1) * p_k - (p_k - rem)
        // This option is considered if there's a remainder (rem > 0)
        // and (q+1)*p_k does not overflow i64.
        if rem > 0 {
            // Cost for (q+1) * p_k: (q+1) uses of p_k and q '+' operators
            let cost_q_plus_1_pk_i64 = if q + 1 == 1 {
                cost_pk as i64
            } else {
                (q as i64 + 1) * (cost_pk as i64) + (q as i64)
            };

            let cost_q_plus_1_pk = cost_q_plus_1_pk_i64 as i32;

            // Add 1 for the '-' operator
            min_cost = min(min_cost, cost_q_plus_1_pk + 1 + self.dfs((p_k - rem as i64) as i32));
        }

        self.memo.insert(target, min_cost);
        min_cost
    }
}

impl Solution {
    pub fn least_ops_expr(x: i32, target: i32) -> i32 {
        let mut solver = Solution::new(x);
        solver.dfs(target)
    }
}