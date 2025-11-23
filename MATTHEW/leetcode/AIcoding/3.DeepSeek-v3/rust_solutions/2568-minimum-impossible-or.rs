impl Solution {
    pub fn min_impossible_or(nums: Vec<i32>) -> i32 {
        let mut mask = 0;
        for &num in nums.iter() {
            if (num & (num - 1)) == 0 {
                mask |= num;
            }
        }
        let mut res = 1;
        while (res & mask) != 0 {
            res <<= 1;
        }
        res
    }
}