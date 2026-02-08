impl Solution {
    pub fn colorful_ball(balls: Vec<i32>) -> i32 {
        let mut counts = std::collections::HashMap::new();
        for ball in balls {
            *counts.entry(ball).or_insert(0) += 1;
        }

        let mut nums: Vec<i32> = counts.values().cloned().collect();
        nums.sort_by(|a, b| b.cmp(a));

        let mut ans = 0;
        let mut available = nums[0];
        for num in nums {
            if available == 0 {
                break;
            }
            if num <= available {
                ans += num;
                available = num - 1;
            } else {
                ans += available;
                available -= 1;
            }
        }

        ans
    }
}