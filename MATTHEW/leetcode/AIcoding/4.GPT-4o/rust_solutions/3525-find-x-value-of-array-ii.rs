impl Solution {
    pub fn find_x_value_of_array(arr: Vec<i32>, x: i32) -> i32 {
        let mut sum = 0;
        for &num in arr.iter() {
            sum += num;
        }
        sum + x
    }
}