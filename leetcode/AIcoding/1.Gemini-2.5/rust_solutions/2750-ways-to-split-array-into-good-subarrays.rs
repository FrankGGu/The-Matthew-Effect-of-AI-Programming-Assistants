impl Solution {
    pub fn ways_to_split_array_into_good_subarrays(nums: Vec<i32>) -> i32 {
        let mut one_indices: Vec<usize> = Vec::new();
        for (i, &num) in nums.iter().enumerate() {
            if num == 1 {
                one_indices.push(i);
            }
        }

        if one_indices.is_empty() {
            return 0;
        }

        let mut ways: i64 = 1;
        let modulo: i64 = 1_000_000_007;

        for j in 0..one_indices.len() - 1 {
            let p_i = one_indices[j];
            let p_i_plus_1 = one_indices[j + 1];
            let num_options_for_gap = (p_i_plus_1 - p_i) as i64;
            ways = (ways * num_options_for_gap) % modulo;
        }

        ways as i32
    }
}