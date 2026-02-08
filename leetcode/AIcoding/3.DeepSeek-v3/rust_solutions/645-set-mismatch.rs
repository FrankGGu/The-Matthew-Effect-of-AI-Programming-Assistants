impl Solution {
    pub fn find_error_nums(nums: Vec<i32>) -> Vec<i32> {
        let mut res = vec![0, 0];
        let mut count = vec![0; nums.len() + 1];
        for &num in nums.iter() {
            count[num as usize] += 1;
        }
        for i in 1..count.len() {
            if count[i] == 2 {
                res[0] = i as i32;
            } else if count[i] == 0 {
                res[1] = i as i32;
            }
        }
        res
    }
}