impl Solution {
    pub fn maximum_points(num_arrows: i32, cost: Vec<i32>) -> Vec<i32> {
        let n = cost.len();
        let mut max_score = -1;
        let mut best_alloc = vec![0; n];

        for mask in 0..(1 << n) {
            let mut arrows_needed = 0;
            let mut score = 0;
            let mut alloc = vec![0; n];

            for i in 0..n {
                if (mask & (1 << i)) != 0 {
                    arrows_needed += cost[i] + 1;
                    score += i as i32;
                    alloc[i] = cost[i] + 1;
                }
            }

            if arrows_needed <= num_arrows {
                if score > max_score {
                    max_score = score;
                    best_alloc = alloc.clone();
                    best_alloc[0] += num_arrows - arrows_needed;
                }
            }
        }

        best_alloc
    }
}