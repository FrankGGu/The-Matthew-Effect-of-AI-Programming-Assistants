impl Solution {
    pub fn triangle_number(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        nums.sort();
        let mut count = 0;
        let n = nums.len();

        for k in 2..n {
            let mut i = 0;
            let mut j = k - 1;
            while i < j {
                if nums[i] + nums[j] > nums[k] {
                    count += (j - i) as i32;
                    j -= 1;
                } else {
                    i += 1;
                }
            }
        }
        count
    }
}