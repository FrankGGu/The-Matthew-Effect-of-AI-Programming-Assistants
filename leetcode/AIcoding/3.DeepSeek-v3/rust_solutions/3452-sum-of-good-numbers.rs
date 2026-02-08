impl Solution {
    pub fn sum_of_good_numbers(nums: Vec<i32>) -> i32 {
        let mut sum = 0;
        for num in nums {
            if is_good(num) {
                sum += num;
            }
        }
        sum
    }
}

fn is_good(num: i32) -> bool {
    // 根据题目要求实现判断逻辑
    true
}