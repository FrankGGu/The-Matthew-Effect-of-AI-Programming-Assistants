use std::collections::HashMap;

pub fn count_ways(ranges: Vec<Vec<i32>>) -> i32 {
    let mut intervals = ranges;
    intervals.sort_by_key(|range| range[0]);

    let mut dp: HashMap<usize, i32> = HashMap::new();
    dp.insert(0, 1);

    for i in 0..intervals.len() {
        let mut sum = 0;
        for j in 0..i {
            if intervals[j][1] < intervals[i][0] {
                sum += dp.get(&j).unwrap_or(&0);
            }
        }
        dp.insert(i, sum + dp.get(&(i - 1)).unwrap_or(&0));
    }

    let total = dp.get(&(intervals.len() - 1)).unwrap_or(&0);
    (total % 1_000_000_007) as i32
}