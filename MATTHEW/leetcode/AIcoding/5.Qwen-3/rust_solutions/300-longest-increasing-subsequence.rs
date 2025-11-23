struct Solution;

impl Solution {
    pub fn length_of_lis(nums: Vec<i32>) -> i32 {
        let mut tails = Vec::new();

        for num in nums {
            let idx = tails.binary_search(&num).unwrap_or_else(|x| x);
            if idx == tails.len() {
                tails.push(num);
            } else {
                tails[idx] = num;
            }
        }

        tails.len() as i32
    }
}