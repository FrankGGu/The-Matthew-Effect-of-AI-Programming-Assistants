impl Solution {
    pub fn can_three_parts_equal_sum(arr: Vec<i32>) -> bool {
        let total_sum: i32 = arr.iter().sum();
        if total_sum % 3 != 0 {
            return false;
        }
        let target = total_sum / 3;
        let mut current_sum = 0;
        let mut parts = 0;

        for num in arr {
            current_sum += num;
            if current_sum == target {
                parts += 1;
                current_sum = 0;
            }
        }
        parts >= 3
    }
}