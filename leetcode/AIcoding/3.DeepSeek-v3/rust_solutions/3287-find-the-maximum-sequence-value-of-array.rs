impl Solution {
    pub fn max_sequence_value(nums: Vec<i32>) -> i64 {
        let mut max1 = 0;
        let mut max2 = 0;
        let mut res = 0;

        for &num in nums.iter() {
            if num as i64 >= max1 {
                max2 = max1;
                max1 = num as i64;
            } else if num as i64 > max2 {
                max2 = num as i64;
            }
            let current = max1 + max2;
            if current > res {
                res = current;
            }
        }

        res
    }
}