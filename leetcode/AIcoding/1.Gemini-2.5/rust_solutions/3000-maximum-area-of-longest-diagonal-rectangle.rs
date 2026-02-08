impl Solution {
    pub fn maximum_area_of_longest_diagonal_rectangle(rectangles: Vec<Vec<i32>>) -> i32 {
        let mut max_diagonal_squared = 0;
        let mut max_area = 0;

        for rect in rectangles {
            let l = rect[0];
            let w = rect[1];

            let current_diagonal_squared = l * l + w * w;
            let current_area = l * w;

            if current_diagonal_squared > max_diagonal_squared {
                max_diagonal_squared = current_diagonal_squared;
                max_area = current_area;
            } else if current_diagonal_squared == max_diagonal_squared {
                max_area = max_area.max(current_area);
            }
        }

        max_area
    }
}