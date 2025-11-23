impl Solution {
    pub fn transform_array(arr: Vec<i32>) -> Vec<i32> {
        let mut result = arr.clone();
        let n = arr.len();

        for _ in 0..100 {
            let mut changed = false;
            let mut new_arr = result.clone();

            for i in 1..(n - 1) {
                if result[i - 1] < result[i] && result[i] > result[i + 1] {
                    new_arr[i] -= 1;
                    changed = true;
                } else if result[i - 1] > result[i] && result[i] < result[i + 1] {
                    new_arr[i] += 1;
                    changed = true;
                }
            }
            result = new_arr;
            if !changed {
                break;
            }
        }

        result
    }
}