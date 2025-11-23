impl Solution {
    pub fn count_hills_and_valleys(nums: Vec<i32>) -> i32 {
        let mut count = 0;
        let mut prev = None;
        let mut peak = None;

        for i in 1..nums.len() {
            if nums[i] != nums[i - 1] {
                if let Some(p) = peak {
                    if (nums[i] > nums[i - 1]) != (nums[p] > nums[p - 1]) {
                        count += 1;
                    }
                }
                peak = Some(i);
                prev = Some(i - 1);
            }
        }
        count
    }
}