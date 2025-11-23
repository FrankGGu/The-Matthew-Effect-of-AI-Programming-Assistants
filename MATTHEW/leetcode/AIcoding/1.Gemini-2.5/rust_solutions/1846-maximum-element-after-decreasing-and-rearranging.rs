impl Solution {
    pub fn maximum_element_after_decreasing_and_rearranging(mut arr: Vec<i32>) -> i32 {
        arr.sort_unstable();
        let mut max_val = 0;
        for num in arr {
            if num > max_val {
                max_val += 1;
            }
        }
        max_val
    }
}