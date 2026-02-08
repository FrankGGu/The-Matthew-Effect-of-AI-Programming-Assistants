impl Solution {
    pub fn min_array_sum(arr: Vec<i32>) -> i32 {
        let mut min_sum = 0;
        let mut min_element = i32::MAX;

        for &num in &arr {
            min_element = min_element.min(num);
            min_sum += min_element;
        }

        min_sum
    }
}