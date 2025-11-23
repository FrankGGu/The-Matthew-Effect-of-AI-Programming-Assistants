impl Solution {
    pub fn can_three_parts_equal_sum(arr: Vec<i32>) -> bool {
        let total_sum: i32 = arr.iter().sum();
        if total_sum % 3 != 0 {
            return false;
        }
        let target = total_sum / 3;
        let mut sum = 0;
        let mut count = 0;
        for &num in arr.iter() {
            sum += num;
            if sum == target {
                count += 1;
                sum = 0;
            }
            if count == 2 {
                return true;
            }
        }
        false
    }
}