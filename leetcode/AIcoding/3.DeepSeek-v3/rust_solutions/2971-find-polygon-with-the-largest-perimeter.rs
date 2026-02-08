impl Solution {
    pub fn largest_perimeter(mut nums: Vec<i32>) -> i64 {
        nums.sort_unstable();
        let mut prefix_sum: i64 = 0;
        let mut res: i64 = -1;
        for &num in nums.iter() {
            let num = num as i64;
            if prefix_sum > num {
                res = prefix_sum + num;
            }
            prefix_sum += num;
        }
        res
    }
}