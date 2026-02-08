impl Solution {
    pub fn area_of_max_diagonal(dimensions: Vec<Vec<i32>>) -> i32 {
        let mut max_diag_sq = 0;
        let mut max_area = 0;

        for rect in dimensions {
            let l = rect[0];
            let w = rect[1];
            let diag_sq = l * l + w * w;
            let area = l * w;

            if diag_sq > max_diag_sq {
                max_diag_sq = diag_sq;
                max_area = area;
            } else if diag_sq == max_diag_sq && area > max_area {
                max_area = area;
            }
        }

        max_area
    }
}