use std::collections::BTreeMap;

impl Solution {
    pub fn full_bloom_flowers(flowers: Vec<Vec<i32>>, people: Vec<i32>) -> Vec<i32> {
        let mut diff = BTreeMap::new();
        for flower in flowers {
            let (start, end) = (flower[0], flower[1]);
            *diff.entry(start).or_insert(0) += 1;
            *diff.entry(end + 1).or_insert(0) -= 1;
        }

        let mut sorted_times: Vec<_> = diff.keys().cloned().collect();
        sorted_times.sort_unstable();

        let mut prefix_sum = 0;
        let mut sum_map = BTreeMap::new();
        for &time in &sorted_times {
            prefix_sum += diff[&time];
            sum_map.insert(time, prefix_sum);
        }

        let mut res = Vec::with_capacity(people.len());
        for &p in &people {
            let &count = sum_map.range(..=p).next_back().map_or(&0, |(_, &sum)| sum);
            res.push(count);
        }
        res
    }
}