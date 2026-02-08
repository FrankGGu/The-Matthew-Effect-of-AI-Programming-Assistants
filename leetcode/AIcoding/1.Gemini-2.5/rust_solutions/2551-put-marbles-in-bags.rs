impl Solution {
    pub fn put_marbles(weights: Vec<i32>, k: i32) -> i64 {
        let n = weights.len();
        let k_usize = k as usize;

        // If k is 1, there's only one bag, so min_cost = max_cost. The difference is 0.
        // If k is n, each marble goes into its own bag, so min_cost = max_cost. The difference is 0.
        // The general logic below correctly handles these cases, resulting in 0.

        // Calculate the sums of adjacent pairs. These represent the "costs" introduced by making a cut.
        // If we make a cut between weights[i] and weights[i+1], then weights[i] becomes the end of a bag
        // and weights[i+1] becomes the start of a new bag.
        // The total cost can be expressed as (weights[0] + weights[n-1]) + sum of (weights[j] + weights[j+1])
        // for each of the k-1 chosen cut points j.
        // To find the minimum total cost, we select the k-1 smallest (weights[j] + weights[j+1]) sums.
        // To find the maximum total cost, we select the k-1 largest (weights[j] + weights[j+1]) sums.
        // The (weights[0] + weights[n-1]) term is common to both min and max total costs, so it cancels out
        // when we compute their difference.

        let mut pair_sums: Vec<i64> = Vec::with_capacity(n - 1);
        for i in 0..(n - 1) {
            pair_sums.push(weights[i] as i64 + weights[i + 1] as i64);
        }

        // Sort the pair_sums to easily pick the smallest and largest k-1 sums.
        pair_sums.sort_unstable();

        let mut min_sum_of_selected_pairs: i64 = 0;
        let mut max_sum_of_selected_pairs: i64 = 0;

        // We need to select k-1 pairs.
        // Sum the smallest k-1 pairs for the minimum total cost component.
        // Sum the largest k-1 pairs for the maximum total cost component.
        for i in 0..(k_usize - 1) {
            min_sum_of_selected_pairs += pair_sums[i];
            max_sum_of_selected_pairs += pair_sums[pair_sums.len() - 1 - i];
        }

        max_sum_of_selected_pairs - min_sum_of_selected_pairs
    }
}