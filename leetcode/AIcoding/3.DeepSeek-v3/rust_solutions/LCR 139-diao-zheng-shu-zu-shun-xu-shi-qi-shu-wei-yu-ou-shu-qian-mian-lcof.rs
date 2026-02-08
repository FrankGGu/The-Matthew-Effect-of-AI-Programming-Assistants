impl Solution {
    pub fn training_plan(mut actions: Vec<i32>) -> Vec<i32> {
        let mut left = 0;
        let mut right = actions.len() - 1;

        while left < right {
            while left < right && actions[left] % 2 == 1 {
                left += 1;
            }
            while left < right && actions[right] % 2 == 0 {
                right -= 1;
            }
            if left < right {
                actions.swap(left, right);
                left += 1;
                right -= 1;
            }
        }
        actions
    }
}