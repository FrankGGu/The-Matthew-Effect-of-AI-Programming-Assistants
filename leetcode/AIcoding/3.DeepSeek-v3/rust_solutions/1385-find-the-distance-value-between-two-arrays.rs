impl Solution {
    pub fn find_the_distance_value(arr1: Vec<i32>, arr2: Vec<i32>, d: i32) -> i32 {
        let mut count = 0;
        for &num1 in &arr1 {
            let mut valid = true;
            for &num2 in &arr2 {
                if (num1 - num2).abs() <= d {
                    valid = false;
                    break;
                }
            }
            if valid {
                count += 1;
            }
        }
        count
    }
}