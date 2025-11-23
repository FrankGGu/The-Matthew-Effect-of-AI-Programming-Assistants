impl Solution {
    pub fn min_subsequence(nums: Vec<i32>) -> Vec<i32> {
        let total: i32 = nums.iter().sum();
        let mut nums = nums;
        nums.sort_unstable_by(|a, b| b.cmp(a));
        let mut subsequence = Vec::new();
        let mut sum = 0;

        for num in nums {
            sum += num;
            subsequence.push(num);
            if sum > total - sum {
                break;
            }
        }

        subsequence
    }
}