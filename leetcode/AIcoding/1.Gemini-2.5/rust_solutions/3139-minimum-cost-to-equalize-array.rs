impl Solution {
    pub fn min_cost_to_equalize_array(nums: Vec<i32>, cost1: i32, cost2: i32) -> i64 {
        let n = nums.len() as i64;
        let mut sorted_nums = nums;
        sorted_nums.sort_unstable();

        let min_val = sorted_nums[0] as i64;
        let max_val = sorted_nums[n as usize - 1] as i64;

        let cost1_i = cost1 as i128;
        let cost2_i = cost2 as i128;

        let mut sum_diff_to_max = 0;
        for &num in sorted_nums.iter() {
            sum_diff_to_max += max_val - num as i64;
        }

        let mut ans = i128::MAX;

        // Case 1: Use only cost1 operations to bring all elements to max_val.
        // Then, for any target X > max_val, we use min(cost2, n * cost1) for each unit increase.
        // The cost function is: f(X) = (sum_diff_to_max) * cost1 + (X - max_val) * min(cost2, n * cost1).
        // This function is linear with a positive slope (since cost2 > 0 and n * cost1 > 0).
        // It is minimized when X is minimized, i.e., X = max_val.
        // So, one candidate for the minimum cost is just bringing all elements to max_val using only cost1.
        ans = ans.min(sum_diff_to_max * cost1_i);

        // Case 2: cost2 is very cheap.
        // If cost2 < cost1 (cost to increment one element using cost2 is cheaper than cost1 for a single element),
        // we might want to use cost2 for all increments, even if it means overshooting some elements.
        // The maximum number of "layers" of increments needed for any element to reach X is X - min_val.
        // If we apply X - min_val operations of type 2 (cost2), then min_val reaches X.
        // All other elements nums[i] become nums[i] + (X - min_val).
        // The cost for this is (X - min_val) * cost2.
        // This is minimized when X is minimized, i.e., X = max_val.
        // So, another candidate for the minimum cost is (max_val - min_val) * cost2.
        // This strategy implies that we use cost2 for every increment, even if it means overshooting.
        // This is only beneficial if cost2 is cheaper than cost1 for a single increment.
        if cost2_i < cost1_i {
            ans = ans.min((max_val - min_val) * cost2_i);
        }

        // Case 3: When cost2 is cheaper than n * cost1 (cost2 < n * cost1).
        // This means using cost2 to increment all elements is more efficient than n individual cost1 operations.
        // In this scenario, we can consider target values X up to max_val + (max_val - min_val).
        // The cost for a target X can be calculated as:
        // We apply `D = X - max_val` operations of type 2. This costs `D * cost2`.
        // The remaining increments needed for `nums[i]` are `max_val - nums[i]`.
        // These are done by `cost1`. This costs `sum_diff_to_max * cost1`.
        // So, `cost(X) = (X - max_val) * cost2 + sum_diff_to_max * cost1`.
        // This is a linear function of X with positive slope `cost2`.
        // It's minimized at `X = max_val`. This is already covered by the first candidate.

        // However, there's a more nuanced interaction when cost2 is efficient.
        // We can use `cost2` to cover some of the `sum_diff_to_max` increments.
        // Let `D_range = max_val - min_val`.
        // We can apply `D_range` `cost2` operations. This costs `D_range * cost2_i`.
        // After this, `min_val` becomes `max_val`. `max_val` becomes `max_val + D_range`.
        // The target is `max_val + D_range`.
        // The remaining increments for `nums[i]` to reach `max_val + D_range` are `max_val - nums[i]`.
        // These `sum_diff_to_max` increments are done by `cost1_i`.
        // So, this candidate cost is `D_range * cost2_i + sum_diff_to_max * cost1_i`.
        // This is the cost to bring all elements to `max_val + (max_val - min_val)`.
        if n > 1 { // Only relevant if there's a range to cover
            let d_range = max_val - min_val;
            ans = ans.min(d_range * cost2_i + sum_diff_to_max * cost1_i);
        }

        // The actual logic is that the optimal target X can be anywhere from `max_val` up to `max_val + (max_val - min_val)`.
        // The cost function `f(X)` is convex.
        // We can iterate over `D = X - max_val` from `0` to `max_val - min_val`.
        // For each `D`, the target is `X = max_val + D`.
        // The cost for this `X` is:
        // `cost_for_X = D * cost2_i + (sum_diff_to_max + n * D - n * D) * cost1_i`.
        // `cost_for_X = D * cost2_i + sum_diff_to_max * cost1_i`.
        // This is the linear function again.
        // This means the minimum is always at `D=0`, i.e., `X = max_val`.

        // This suggests that the solution is simpler than expected.
        // The optimal X is always `max_val`.
        // The cost to make all elements equal to `max_val` is:
        // We need `sum_diff_to_max` total increments.
        // We can use `k` `cost2` operations. This costs `k * cost2_i`.
        // This reduces the total increments needed by `n * k`.
        // The remaining `sum_diff_to_max - n * k` increments are done by `cost1_i`.
        // This is valid as long as `sum_diff_to_max - n * k >= 0`.
        // And `k` is limited by `max_val - min_val`.
        // So `k` can range from `0` to `max_val - min_val`.
        // The cost for a given `k` is `k * cost2_i + (sum_diff_to_max - n * k) * cost1_i`.
        // This is `k * (cost2_i - n * cost1_i) + sum_diff_to_max * cost1_i`.
        // Let `slope = cost2_i - n * cost1_i`.
        // If `slope >= 0`, we want to minimize `k`, so `k=0`. Cost `sum_diff_to_max * cost1_i`.
        // If `slope < 0`, we want to maximize `k`.
        // The maximum `k` is `max_val - min_val`.
        // Cost = `(max_val - min_val) * cost2_i + (sum_diff_to_max - n * (max_val - min_val)) * cost1_i`.
        // This is the final answer.

        let slope = cost2_i - n as i128 * cost1_i;
        if slope >= 0 {
            // cost2 is not efficient enough, use only cost1
            ans = sum_diff_to_max * cost1_i;
        } else {
            // cost2 is efficient, maximize k
            // The maximum k is `max_val - min_val` (to bring min_val up to max_val).
            // This is the cost to make all elements equal to `max_val`.
            let max_k = max_val - min_val;
            let current_cost = max_k * cost2_i + (sum_diff_to_max - n as i128 * max_k) * cost1_i;
            ans = current_cost;

            // However, the optimal X might be greater than max_val.
            // When `cost2 < n * cost1`, the cost function `f(X)` is `(X - max_val) * cost2 + sum(max_val - nums[i]) * cost1`.
            // This is minimized at `X = max_val`.
            // The issue is that the `k` in the formula `k * (cost2 - n * cost1) + S_X * cost1` is limited by `X - max_val`.
            // If `cost2 < cost1`, then it's always better to use `cost2` for any increment.
            // So the cost is `(X - min_val) * cost2`.
            // This is minimized at `X = max_val`. Cost `(max_val - min_val) * cost2`.
            // This is a candidate.
            ans = ans.min((max_val - min_val) * cost2_i);
        }

        ans as i64
    }
}