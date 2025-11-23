impl Solution {
    pub fn minimize_the_difference(mat: Vec<Vec<i32>>, target: i32) -> i32 {
        let m = mat.len();
        let max_possible_sum = 70 * 70; 

        let mut possible_sums = vec![false; max_possible_sum + 1];

        for &val in &mat[0] {
            possible_sums[val as usize] = true;
        }

        for i in 1..m {
            let mut new_possible_sums = vec![false; max_possible_sum + 1];
            for sum in 0..=max_possible_sum {
                if possible_sums[sum] {
                    for &val in &mat[i] {
                        if sum + val as usize <= max_possible_sum {
                            new_possible_sums[sum + val as usize] = true;
                        }
                    }
                }
            }
            possible_sums = new_possible_sums;
        }

        let mut min_diff = i32::MAX;
        for sum in 0..=max_possible_sum {
            if possible_sums[sum] {
                min_diff = min_diff.min((sum as i32 - target).abs());
            }
        }

        min_diff
    }
}