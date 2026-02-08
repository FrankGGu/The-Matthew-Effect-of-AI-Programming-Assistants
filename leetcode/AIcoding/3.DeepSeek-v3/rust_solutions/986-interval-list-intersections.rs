impl Solution {
    pub fn interval_intersection(first_list: Vec<Vec<i32>>, second_list: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut result = Vec::new();
        let mut i = 0;
        let mut j = 0;

        while i < first_list.len() && j < second_list.len() {
            let start = std::cmp::max(first_list[i][0], second_list[j][0]);
            let end = std::cmp::min(first_list[i][1], second_list[j][1]);

            if start <= end {
                result.push(vec![start, end]);
            }

            if first_list[i][1] < second_list[j][1] {
                i += 1;
            } else {
                j += 1;
            }
        }

        result
    }
}