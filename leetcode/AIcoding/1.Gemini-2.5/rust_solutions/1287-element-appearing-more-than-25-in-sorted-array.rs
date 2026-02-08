impl Solution {
    pub fn find_special_integer(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let threshold = n / 4;

        if n == 1 {
            return arr[0];
        }

        let mut current_element = arr[0];
        let mut count = 1;

        for i in 1..n {
            if arr[i] == current_element {
                count += 1;
            } else {
                if count > threshold {
                    return current_element;
                }
                current_element = arr[i];
                count = 1;
            }
        }

        if count > threshold {
            return current_element;
        }

        unreachable!();
    }
}