impl Solution {
    pub fn sort_even_odd(nums: Vec<i32>) -> Vec<i32> {
        let mut even: Vec<i32> = nums.iter().enumerate().filter(|(i, _)| i % 2 == 0).map(|(_, &x)| x).collect();
        let mut odd: Vec<i32> = nums.iter().enumerate().filter(|(i, _)| i % 2 != 0).map(|(_, &x)| x).collect();

        even.sort();
        odd.sort_by(|a, b| b.cmp(a));

        let mut result: Vec<i32> = Vec::new();
        let mut even_idx = 0;
        let mut odd_idx = 0;

        for i in 0..nums.len() {
            if i % 2 == 0 {
                result.push(even[even_idx]);
                even_idx += 1;
            } else {
                result.push(odd[odd_idx]);
                odd_idx += 1;
            }
        }

        result
    }
}