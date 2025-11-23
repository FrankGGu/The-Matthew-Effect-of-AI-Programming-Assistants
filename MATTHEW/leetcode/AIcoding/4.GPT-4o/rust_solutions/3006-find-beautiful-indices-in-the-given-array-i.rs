impl Solution {
    pub fn beautiful_indices(nums: Vec<i32>, k: i32) -> Vec<i32> {
        let mut result = Vec::new();
        let n = nums.len();

        for i in 0..n {
            let mut count = 0;
            for j in 0..n {
                if nums[j] > nums[i] {
                    count += 1;
                }
            }
            if count == k {
                result.push(i as i32);
            }
        }

        result
    }
}