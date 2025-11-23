impl Solution {
    pub fn min_operations(nums: Vec<i32>, target: i32) -> i32 {
        let mut operations = 0;
        let mut current_sum = 0;
        let mut nums_sorted = nums.clone();
        nums_sorted.sort();

        for &num in &nums_sorted {
            current_sum += num;
        }

        if current_sum < target {
            return -1;
        }

        let mut pq: std::collections::BinaryHeap<i64> = nums_sorted.iter().map(|&x| x as i64).collect();

        while current_sum > target {
            let top = pq.pop().unwrap();
            if current_sum - top >= target {
                current_sum -= top;
            } else {
                operations += 1;
                current_sum += top;
                pq.push(top / 2);
                pq.push(top / 2);
            }
        }

        operations
    }
}