impl Solution {
    pub fn maximum_element_after_decreasing_and_rearranging(arr: Vec<i32>) -> i32 {
        let mut arr = arr;
        arr.sort_unstable();
        let mut max_element = 0;
        for &num in &arr {
            max_element = max_element.max(num.min(max_element + 1));
        }
        max_element
    }
}