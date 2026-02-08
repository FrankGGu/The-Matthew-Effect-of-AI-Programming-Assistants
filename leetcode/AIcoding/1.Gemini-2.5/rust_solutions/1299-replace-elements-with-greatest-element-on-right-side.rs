impl Solution {
    pub fn replace_elements(arr: &mut Vec<i32>) {
        let n = arr.len();
        if n == 0 {
            return;
        }

        let mut max_so_far = -1;

        for i in (0..n).rev() {
            let current_element = arr[i];
            arr[i] = max_so_far;
            max_so_far = current_element.max(max_so_far);
        }
    }
}