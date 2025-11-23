impl Solution {
    pub fn min_operations(nums: Vec<i32>) -> i32 {
        let mut res = 0;
        let mut prev = 0;
        for num in nums {
            if num > prev {
                res += num - prev;
            }
            prev = num;
        }
        res
    }
}