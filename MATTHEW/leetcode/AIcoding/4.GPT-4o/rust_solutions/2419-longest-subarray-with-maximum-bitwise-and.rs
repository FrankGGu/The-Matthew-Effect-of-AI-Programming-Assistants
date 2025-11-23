impl Solution {
    pub fn longest_subarray(arr: Vec<i32>) -> i32 {
        let max_bitwise_and = *arr.iter().max().unwrap();
        let mut max_length = 0;
        let mut current_length = 0;

        for &num in arr.iter() {
            if num == max_bitwise_and {
                current_length += 1;
            } else {
                max_length = max_length.max(current_length);
                current_length = 0;
            }
        }

        max_length.max(current_length)
    }
}