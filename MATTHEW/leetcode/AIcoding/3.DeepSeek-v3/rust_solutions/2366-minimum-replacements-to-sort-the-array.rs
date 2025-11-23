impl Solution {
    pub fn minimum_replacement(nums: Vec<i32>) -> i64 {
        let mut res = 0;
        let mut last = *nums.last().unwrap() as i64;
        for &num in nums.iter().rev().skip(1) {
            let num = num as i64;
            let k = (num + last - 1) / last;
            res += k - 1;
            last = num / k;
        }
        res
    }
}