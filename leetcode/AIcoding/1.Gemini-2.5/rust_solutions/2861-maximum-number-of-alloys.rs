impl Solution {
    pub fn max_number_of_alloys(
        n: i32,
        k: i32,
        budget: i32,
        composition: Vec<Vec<i32>>,
        stock: Vec<i32>,
        cost: Vec<i32>,
    ) -> i32 {
        let n_usize = n as usize;
        let k_usize = k as usize;
        let budget_i64 = budget as i64;
        let stock_i64: Vec<i64> = stock.into_iter().map(|x| x as i64).collect();
        let cost_i64: Vec<i64> = cost.into_iter().map(|x| x as i64).collect();

        let mut low = 0i64;
        let mut high = 2_000_000_000i64; // A sufficiently large upper bound for the number of alloys
        let mut ans = 0i64;

        while low <= high {
            let mid = low + (high - low) / 2;

            let mut possible = false;
            for i in 0..n_usize { // Iterate through each factory
                let mut current_factory_cost = 0i64;
                let mut factory_i_possible = true;

                for j in 0..k_usize { // Iterate through each item
                    let required_item_j = composition[i][j] as i64 * mid;
                    let needed_to_buy_item_j = required_item_j.saturating_sub(stock_i64[j]);

                    if needed_to_buy_item_j > 0 {
                        let item_cost_per_unit = cost_i64[j];

                        // Check for potential overflow AND if cost would exceed remaining budget
                        // The condition needed_to_buy_item_j * item_cost_per_unit > budget_i64 - current_factory_cost
                        // is checked by rearranging to avoid overflow:
                        // needed_to_buy_item_j > (budget_i64 - current_factory_cost) / item_cost_per_unit
                        // This only works if item_cost_per_unit > 0.
                        if item_cost_per_unit > 0 {
                            if needed_to_buy_item_j > (budget_i64 - current_factory_cost) / item_cost_per_unit {
                                factory_i_possible = false;
                                break;
                            }
                        }
                        current_factory_cost += needed_to_buy_item_j * item_cost_per_unit;
                    }
                }

                if factory_i_possible {
                    possible = true;
                    break; // Found one factory that can make 'mid' alloys
                }
            }

            if possible {
                ans = mid; // This 'mid' is possible, try for more
                low = mid + 1;
            } else {
                high = mid - 1; // This 'mid' is not possible, try for fewer
            }
        }

        ans as i32
    }
}