impl Solution {
    pub fn relative_sort_array(arr1: Vec<i32>, arr2: Vec<i32>) -> Vec<i32> {
        let mut result = Vec::new();
        let mut remaining = Vec::new();

        for &num in &arr2 {
            for &val in &arr1 {
                if val == num {
                    result.push(val);
                }
            }
        }

        for &val in &arr1 {
            if !arr2.contains(&val) {
                remaining.push(val);
            }
        }

        remaining.sort();
        result.extend(remaining);

        result
    }
}