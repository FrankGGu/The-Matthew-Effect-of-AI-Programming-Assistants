impl Solution {
    pub fn minimum_operations(nums: Vec<i32>, target: Vec<i32>) -> i64 {
        let n = nums.len();
        let mut nums_even: Vec<i64> = Vec::new();
        let mut nums_odd: Vec<i64> = Vec::new();
        let mut target_even: Vec<i64> = Vec::new();
        let mut target_odd: Vec<i64> = Vec::new();

        for i in 0..n {
            if nums[i] % 2 == 0 {
                nums_even.push(nums[i] as i64);
            } else {
                nums_odd.push(nums[i] as i64);
            }

            if target[i] % 2 == 0 {
                target_even.push(target[i] as i64);
            } else {
                target_odd.push(target[i] as i64);
            }
        }

        nums_even.sort_unstable();
        nums_odd.sort_unstable();
        target_even.sort_unstable();
        target_odd.sort_unstable();

        let mut operations: i64 = 0;

        for i in 0..nums_even.len() {
            if target_even[i] > nums_even[i] {
                operations += (target_even[i] - nums_even[i]) / 2;
            }
        }

        for i in 0..nums_odd.len() {
            if target_odd[i] > nums_odd[i] {
                operations += (target_odd[i] - nums_odd[i]) / 2;
            }
        }

        operations
    }
}