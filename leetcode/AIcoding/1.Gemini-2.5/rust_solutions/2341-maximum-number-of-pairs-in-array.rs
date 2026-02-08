impl Solution {
    pub fn number_of_pairs(nums: Vec<i32>) -> Vec<i32> {
        let mut counts = [0; 101];
        for &num in nums.iter() {
            counts[num as usize] += 1;
        }

        let mut pairs = 0;
        let mut remaining = 0;

        for &count in counts.iter() {
            pairs += count / 2;
            remaining += count % 2;
        }

        vec![pairs, remaining]
    }
}