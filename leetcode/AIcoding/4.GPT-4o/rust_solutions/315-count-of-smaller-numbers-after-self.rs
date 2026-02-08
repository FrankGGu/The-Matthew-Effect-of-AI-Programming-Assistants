impl Solution {
    pub fn count_smaller(nums: Vec<i32>) -> Vec<i32> {
        let mut counts = vec![0; nums.len()];
        let mut sorted = Vec::new();

        for (i, &num) in nums.iter().enumerate().rev() {
            let pos = sorted.binary_search(&num).unwrap_or_else(|x| x);
            counts[i] = pos as i32;
            sorted.insert(pos, num);
        }

        counts
    }
}