impl Solution {
    pub fn number_of_ways_to_place_people(points: Vec<Vec<i32>>) -> i32 {
        let n = points.len();
        let mut count = 0;

        for i in 0..n {
            for j in 0..n {
                if i == j {
                    continue;
                }

                let xi = points[i][0];
                let yi = points[i][1];
                let xj = points[j][0];
                let yj = points[j][1];

                // Condition 1: Person i can be placed to the left and below person j
                // xi <= xj and yi <= yj
                let c1_i_below_j = xi <= xj && yi <= yj;

                // Condition 2: Person j cannot be placed to the left and below person i
                // NOT (xj <= xi and yj <= yi)
                // This is equivalent to xj > xi OR yj > yi
                let c2_j_not_below_i = xj > xi || yj > yi;

                if c1_i_below_j && c2_j_not_below_i {
                    count += 1;
                }
            }
        }

        count
    }
}