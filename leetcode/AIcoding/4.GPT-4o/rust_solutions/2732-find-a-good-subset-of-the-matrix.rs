struct Solution;

impl Solution {
    pub fn find_good_subset(matrix: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut good_subset = vec![];
        let mut max_sum = i32::MIN;

        let n = matrix.len();
        let m = matrix[0].len();

        for i in 0..n {
            for j in 0..m {
                let mut current_subset = vec![];
                let mut current_sum = 0;

                for x in i..n {
                    for y in j..m {
                        current_subset.push(matrix[x][y]);
                        current_sum += matrix[x][y];
                    }
                }

                if current_sum > max_sum {
                    max_sum = current_sum;
                    good_subset = current_subset;
                }
            }
        }

        good_subset
    }
}