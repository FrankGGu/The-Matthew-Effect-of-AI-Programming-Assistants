impl Solution {
    pub fn interval_list_intersections(first_list: Vec<Vec<i32>>, second_list: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut result: Vec<Vec<i32>> = Vec::new();
        let mut i = 0;
        let mut j = 0;

        while i < first_list.len() && j < second_list.len() {
            let a1 = first_list[i][0];
            let a2 = first_list[i][1];
            let b1 = second_list[j][0];
            let b2 = second_list[j][1];

            let low = std::cmp::max(a1, b1);
            let high = std::cmp::min(a2, b2);

            if low <= high {
                result.push(vec![low, high]);
            }

            if a2 < b2 {
                i += 1;
            } else {
                j += 1;
            }
        }

        result
    }
}