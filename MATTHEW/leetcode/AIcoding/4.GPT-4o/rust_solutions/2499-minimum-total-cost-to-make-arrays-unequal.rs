pub fn minimum_total_cost(nums: Vec<i32>) -> i32 {
    let mut cost = 0;
    let mut count = std::collections::HashMap::new();

    for &num in &nums {
        *count.entry(num).or_insert(0) += 1;
    }

    for &num in &nums {
        if count[&num] > 1 {
            cost += num / 2;
            count.insert(num, count[&num] - 1);
        }
    }

    cost
}