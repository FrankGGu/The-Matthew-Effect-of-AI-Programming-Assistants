impl Solution {
    pub fn maximum_spend(items: Vec<i32>, budget: i32) -> i32 {
        let mut max_spend = 0;
        let n = items.len();

        for i in 0..(1 << n) {
            let mut current_sum = 0;
            for j in 0..n {
                if i & (1 << j) != 0 {
                    current_sum += items[j];
                }
            }
            if current_sum <= budget {
                max_spend = max_spend.max(current_sum);
            }
        }

        max_spend
    }
}