impl Solution {
    pub fn max_two_events(events: Vec<Vec<i32>>) -> i32 {
        let mut events = events;
        events.sort_by_key(|x| x[1]);
        let n = events.len();
        let mut suffix_max = vec![0; n + 1];
        for i in (0..n).rev() {
            suffix_max[i] = std::cmp::max(suffix_max[i + 1], events[i][2]);
        }
        let mut ans = 0;
        let mut prefix_max = 0;
        for i in 0..n {
            let start = events[i][0];
            let end = events[i][1];
            let value = events[i][2];
            let mut left = 0;
            let mut right = n;
            while left < right {
                let mid = (left + right) / 2;
                if events[mid][1] < start {
                    left = mid + 1;
                } else {
                    right = mid;
                }
            }
            ans = std::cmp::max(ans, value + suffix_max[left]);
        }
        ans
    }
}