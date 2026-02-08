impl Solution {
    pub fn find_the_distance_value(arr1: Vec<i32>, arr2: Vec<i32>, d: i32) -> i32 {
        let mut count = 0;
        for &num1 in &arr1 {
            let mut found_close = false;
            for &num2 in &arr2 {
                if (num1 - num2).abs() <= d {
                    found_close = true;
                    break;
                }
            }
            if !found_close {
                count += 1;
            }
        }
        count
    }
}