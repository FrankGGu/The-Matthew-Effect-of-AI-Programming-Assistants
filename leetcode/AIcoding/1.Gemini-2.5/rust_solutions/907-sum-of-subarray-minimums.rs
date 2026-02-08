impl Solution {
    pub fn sum_subarray_mins(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut ple = vec![-1; n]; // Previous Less Element index
        let mut nle = vec![n as i32; n]; // Next Less Element index

        let mut stack: Vec<usize> = Vec::new();

        // Calculate ple (Previous Less Element)
        // For arr[i], find the index of the first element to its left that is strictly smaller than arr[i].
        // If arr[j] == arr[i], we pop j, ensuring arr[i] is considered the "first" for its value.
        for i in 0..n {
            while let Some(&top_idx) = stack.last() {
                if arr[top_idx] >= arr[i] {
                    stack.pop();
                } else {
                    break;
                }
            }
            if let Some(&top_idx) = stack.last() {
                ple[i] = top_idx as i32;
            }
            stack.push(i);
        }

        stack.clear();

        // Calculate nle (Next Less Element)
        // For arr[i], find the index of the first element to its right that is smaller than or equal to arr[i].
        // If arr[j] == arr[i], we don't pop j, ensuring arr[i] is considered to be "to the left" of equal elements.
        for i in (0..n).rev() {
            while let Some(&top_idx) = stack.last() {
                if arr[top_idx] > arr[i] {
                    stack.pop();
                } else {
                    break;
                }
            }
            if let Some(&top_idx) = stack.last() {
                nle[i] = top_idx as i32;
            }
            stack.push(i);
        }

        let mut total_sum: i64 = 0;
        let modulo: i64 = 1_000_000_007;

        for i in 0..n {
            let left_count = i as i64 - ple[i] as i64;
            let right_count = nle[i] as i64 - i as i64;

            let val = arr[i] as i64;

            let contribution = (val * left_count) % modulo;
            let contribution = (contribution * right_count) % modulo;

            total_sum = (total_sum + contribution) % modulo;
        }

        total_sum as i32
    }
}