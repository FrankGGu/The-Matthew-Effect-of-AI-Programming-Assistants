impl Solution {
    pub fn find_the_distance_value(arr1: Vec<i32>, arr2: Vec<i32>, d: i32) -> i32 {
        let mut distance_value_count = 0;

        for &num1 in arr1.iter() {
            let mut is_valid = true;
            for &num2 in arr2.iter() {
                if (num1 - num2).abs() <= d {
                    is_valid = false;
                    break;
                }
            }
            if is_valid {
                distance_value_count += 1;
            }
        }

        distance_value_count
    }
}