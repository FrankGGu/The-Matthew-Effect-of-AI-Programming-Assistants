pub fn intersection_size_two(intervals: Vec<Vec<i32>>) -> i32 {
    let mut intervals = intervals;
    intervals.sort_by_key(|x| (x[1], x[0]));
    let mut result = 0;
    let mut end = vec![];

    for interval in intervals.iter().rev() {
        let start = interval[0];
        let mut count = 0;

        while let Some(&x) = end.last() {
            if x >= start {
                count += 1;
                end.pop();
            } else {
                break;
            }
        }

        while count < 2 {
            end.push(interval[1] - (count as i32));
            count += 1;
            result += 1;
        }
    }

    result
}