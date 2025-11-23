impl Solution {
    pub fn single_number(nums: Vec<i32>) -> i32 {
        let mut seen_once = 0;
        let mut seen_twice = 0;

        for num in nums {
            seen_once = !seen_twice & (seen_once ^ num);
            seen_twice = !seen_once & (seen_twice ^ num);
        }

        seen_once
    }
}