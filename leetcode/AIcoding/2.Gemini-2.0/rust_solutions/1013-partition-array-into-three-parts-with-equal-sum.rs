impl Solution {
    pub fn can_three_parts_equal_sum(arr: Vec<i32>) -> bool {
        let sum: i32 = arr.iter().sum();
        if sum % 3 != 0 {
            return false;
        }
        let target = sum / 3;
        let mut count = 0;
        let mut current_sum = 0;
        for &num in &arr {
            current_sum += num;
            if current_sum == target {
                count += 1;
                current_sum = 0;
            }
        }
        count >= 3
    }
}