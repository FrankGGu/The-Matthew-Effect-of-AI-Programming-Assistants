impl Solution {
    pub fn maximum_count(nums: Vec<i32>) -> i32 {
        let pos = nums.iter().filter(|&&x| x > 0).count() as i32;
        let neg = nums.iter().filter(|&&x| x < 0).count() as i32;
        std::cmp::max(pos, neg)
    }
}