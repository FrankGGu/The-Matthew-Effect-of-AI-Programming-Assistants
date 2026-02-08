impl Solution {
    pub fn is_self_crossing(distances: Vec<i32>) -> bool {
        let n = distances.len();
        if n < 4 {
            return false;
        }

        for i in 3..n {
            if distances[i] >= distances[i - 2] && distances[i - 1] <= distances[i - 3] {
                return true;
            }

            if i >= 4 {
                if distances[i - 1] == distances[i - 3] && distances[i] + distances[i - 4] >= distances[i - 2] {
                    return true;
                }
            }

            if i >= 5 {
                if distances[i - 2] >= distances[i - 4] &&
                   distances[i - 1] >= distances[i - 3] &&
                   distances[i - 1] <= distances[i - 3] - distances[i - 5] &&
                   distances[i] >= distances[i - 2] - distances[i - 4] {
                    return true;
                }
            }
        }

        false
    }
}