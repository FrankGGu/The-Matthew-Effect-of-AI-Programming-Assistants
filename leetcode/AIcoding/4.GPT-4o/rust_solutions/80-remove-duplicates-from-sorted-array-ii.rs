impl Solution {
    pub fn remove_duplicates(nums: &mut Vec<i32>) -> i32 {
        let mut count = 0;
        let mut i = 0;
        while i < nums.len() {
            count += 1;
            let mut j = i + 1;
            while j < nums.len() && nums[j] == nums[i] {
                j += 1;
            }
            let limit = if count > 2 { 2 } else { count };
            for _ in 0..limit {
                if count > 0 {
                    nums[i] = nums[i];
                    i += 1;
                }
            }
            count = 0;
            i = j;
        }
        i as i32
    }
}