impl Solution {
    pub fn find_all_k_distant_indices(nums: Vec<i32>, key: i32, k: i32) -> Vec<i32> {
        let mut result: Vec<i32> = Vec::new();
        let n = nums.len();

        for i in 0..n {
            for j in 0..n {
                if nums[j] == key && (i as i32 - j as i32).abs() <= k {
                    result.push(i as i32);
                    break;
                }
            }
        }

        result.sort();
        result.dedup();
        result
    }
}