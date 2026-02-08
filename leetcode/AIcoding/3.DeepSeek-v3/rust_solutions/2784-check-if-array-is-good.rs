impl Solution {
    pub fn is_good(nums: Vec<i32>) -> bool {
        let n = nums.len() as i32;
        let mut freq = vec![0; (n + 1) as usize];
        for &num in &nums {
            if num > n || num < 1 {
                return false;
            }
            freq[num as usize] += 1;
        }
        if freq[n as usize] != 2 {
            return false;
        }
        for i in 1..n {
            if freq[i as usize] != 1 {
                return false;
            }
        }
        true
    }
}