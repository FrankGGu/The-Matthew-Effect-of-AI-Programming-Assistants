pub fn sum_of_imbalance_numbers(nums: Vec<i32>) -> i64 {
    let n = nums.len();
    let mut total_imbalance = 0;

    for start in 0..n {
        let mut count = std::collections::HashMap::new();
        let mut imbalance = 0;

        for end in start..n {
            let num = nums[end];
            let lower = count.range(..num).count() as i64;
            let upper = count.range(num..).count() as i64;

            imbalance += upper - lower;
            total_imbalance += imbalance;

            *count.entry(num).or_insert(0) += 1;
        }
    }

    total_imbalance
}