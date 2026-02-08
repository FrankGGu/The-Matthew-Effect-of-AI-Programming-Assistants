impl Solution {
    pub fn three_equal_parts(arr: Vec<i32>) -> Vec<i32> {
        let n = arr.len();
        let mut one_indices = Vec::new();
        for (i, &val) in arr.iter().enumerate() {
            if val == 1 {
                one_indices.push(i);
            }
        }

        let total_ones = one_indices.len();

        if total_ones == 0 {
            // All zeros, any valid partition works.
            // [0, 0, 0] -> [0, 1]
            // [0, 0, 0, 0] -> [0, 2]
            // The problem requires non-empty parts, so arr.len() must be at least 3.
            if n < 3 {
                return vec![-1, -1];
            }
            return vec![0, (n - 2) as i32];
        }

        if total_ones % 3 != 0 {
            return vec![-1, -1];
        }

        let ones_per_part = total_ones / 3;

        // Find the indices of the first and last '1' in each conceptual part.
        let p1_start = one_indices[0];
        let p1_end = one_indices[ones_per_part - 1];

        let p2_start = one_indices[ones_per_part];
        let p2_end = one_indices[2 * ones_per_part - 1];

        let p3_start = one_indices[2 * ones_per_part];
        let p3_end = one_indices[3 * ones_per_part - 1]; // This is one_indices[total_ones - 1]

        // The number of trailing zeros required for each part to have the same value.
        // This is determined by the trailing zeros of the third part.
        let trailing_zeros = n - 1 - p3_end;

        // Calculate the proposed partition points i and j.
        // i is the last index of the first part: arr[0...i]
        // j is the last index of the second part: arr[i+1...j]
        // The third part is arr[j+1...n-1]
        let i = p1_end + trailing_zeros;
        let j = p2_end + trailing_zeros;

        // Check boundary conditions for i and j.
        // 1. The first part's trailing zeros should not extend into the second part's ones.
        // 2. The second part's trailing zeros should not extend into the third part's ones.
        // 3. The second part (arr[i+1...j]) must be non-empty.
        // 4. The third part (arr[j+1...n-1]) must be non-empty.
        if i >= p2_start || j >= p3_start || i + 1 > j || j + 1 > n - 1 {
            return vec![-1, -1];
        }

        // Verify that the three parts (from their first '1' to their end, including trailing zeros) are identical.
        // The length of these "significant" parts is determined by the third part.
        let len_part = n - p3_start; // Length from p3_start to the end of the array.

        for k in 0..len_part {
            if arr[p1_start + k] != arr[p2_start + k] || arr[p2_start + k] != arr[p3_start + k] {
                return vec![-1, -1];
            }
        }

        vec![i as i32, j as i32]
    }
}