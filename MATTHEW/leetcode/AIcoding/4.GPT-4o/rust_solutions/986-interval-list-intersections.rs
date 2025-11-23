pub fn interval_intersection(first_list: Vec<Vec<i32>>, second_list: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
    let mut i = 0;
    let mut j = 0;
    let mut result = Vec::new();

    while i < first_list.len() && j < second_list.len() {
        let start1 = first_list[i][0];
        let end1 = first_list[i][1];
        let start2 = second_list[j][0];
        let end2 = second_list[j][1];

        if start1 <= end2 && start2 <= end1 {
            result.push(vec![start1.max(start2), end1.min(end2)]);
        }

        if end1 < end2 {
            i += 1;
        } else {
            j += 1;
        }
    }

    result
}