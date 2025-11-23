impl Solution {
    pub fn sum_imbalance_numbers(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut total = 0;

        for i in 0..n {
            let mut seen = std::collections::HashSet::new();
            seen.insert(nums[i]);
            let mut imbalance = 0;

            for j in (i + 1)..n {
                let x = nums[j];
                if !seen.contains(&x) {
                    if seen.contains(&(x - 1)) && seen.contains(&(x + 1)) {
                        imbalance -= 1;
                    } else if !seen.contains(&(x - 1)) && !seen.contains(&(x + 1)) {
                        imbalance += 1;
                    }
                    seen.insert(x);
                }
                total += imbalance;
            }
        }

        total
    }
}