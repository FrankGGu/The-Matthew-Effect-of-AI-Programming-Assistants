impl Solution {
    pub fn minimize_the_difference(mat: Vec<Vec<i32>>, target: i32) -> i32 {
        let m = mat.len();
        let mut possible_sums: std::collections::HashSet<i32> = std::collections::HashSet::new();
        possible_sums.insert(0);

        for row in mat {
            let mut next_possible_sums: std::collections::HashSet<i32> = std::collections::HashSet::new();
            for sum in &possible_sums {
                for num in &row {
                    next_possible_sums.insert(sum + num);
                }
            }
            possible_sums = next_possible_sums;
        }

        let mut min_diff = i32::MAX;
        for sum in possible_sums {
            min_diff = min_diff.min((sum - target).abs());
        }

        min_diff
    }
}