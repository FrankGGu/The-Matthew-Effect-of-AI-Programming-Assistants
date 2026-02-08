impl Solution {
    pub fn minimum_deletions(nums: Vec<i32>) -> i32 {
        let mut count = 0;
        let mut last = None;

        for &num in nums.iter().rev() {
            if Some(num % 2) == last {
                count += 1;
            } else {
                last = Some(num % 2);
            }
        }

        count
    }
}