impl Solution {
    pub fn minimum_replacement(nums: Vec<i32>) -> i32 {
        let mut count = 0;
        let mut prev = nums.last().copied().unwrap();

        for &num in nums.iter().rev() {
            if num > prev {
                let parts = (num + prev - 1) / prev;
                count += parts - 1;
                prev = num / parts;
            } else {
                prev = num;
            }
        }

        count
    }
}