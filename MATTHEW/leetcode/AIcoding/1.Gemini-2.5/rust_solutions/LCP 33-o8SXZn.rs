impl Solution {
    pub fn store_water(bucket: Vec<i32>, vat: Vec<i32>) -> i32 {
        let n = bucket.len();

        let mut max_vat_val = 0;
        for &v in vat.iter() {
            if v > max_vat_val {
                max_vat_val = v;
            }
        }

        if max_vat_val == 0 {
            return 0;
        }

        let mut min_total_cost: i64 = std::i64::MAX;

        // Case 1: T (maximum pour operations) is very large, specifically T >= max_vat_val.
        // In this scenario, for any vat[i] > 0, ceil(vat[i] / T) will be 1.
        // This means each vat needs at most 1 pour operation.
        // The upgrade cost for vat[i] is max(0, 1 - bucket[i]).
        // The total cost would be T + sum(max(0, 1 - bucket[i])).
        // This cost is minimized when T is the smallest possible in this range, which is max_vat_val.
        let mut upgrades_for_T_large = 0_i64;
        for i in 0..n {
            if vat[i] > 0 {
                upgrades_for_T_large += (0_i64).max(1 - bucket[i] as i64);
            }
        }
        min_total_cost = min_total_cost.min(max_vat_val as i64 + upgrades_for_T_large);

        // Case 2: Iterate T (maximum pour operations) from 1 up to a fixed limit.
        // A common limit for such problems, related to N_max (10^5), is 100000 or 200000.
        // We use 100001 as a reasonable upper bound for T.
        // If max_vat_val is smaller than this limit, the loop will effectively run up to max_vat_val.
        let t_limit = 100001; 

        for t in 1..=t_limit {
            let mut current_upgrade_cost = 0_i64;
            for i in 0..n {
                if vat[i] == 0 {
                    continue;
                }

                // Calculate the required capacity for this bucket to fill vat[i] in 't' pours.
                // This is ceil(vat[i] / t). Using integer division: (A + B - 1) / B.
                let required_capacity = (vat[i] as i64 + t as i64 - 1) / (t as i64);

                // Calculate upgrades needed for this bucket.
                // If current bucket capacity is less than required, upgrade. Otherwise, no upgrade needed.
                current_upgrade_cost += (0_i64).max(required_capacity - bucket[i] as i64);
            }
            // Update the minimum total cost.
            min_total_cost = min_total_cost.min(t as i64 + current_upgrade_cost);
        }

        min_total_cost as i32
    }
}