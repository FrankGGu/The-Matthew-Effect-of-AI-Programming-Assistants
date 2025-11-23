impl Solution {
    pub fn circular_permutation(n: i32, start: i32) -> Vec<i32> {
        let len = 1 << n;
        let mut result = Vec::with_capacity(len);
        for i in 0..len {
            result.push(i ^ (i >> 1));
        }
        let mut start_index = 0;
        for i in 0..len {
            if result[i] == start {
                start_index = i;
                break;
            }
        }
        let mut rotated_result = Vec::with_capacity(len);
        for i in 0..len {
            rotated_result.push(result[(start_index + i) % len]);
        }
        rotated_result
    }
}