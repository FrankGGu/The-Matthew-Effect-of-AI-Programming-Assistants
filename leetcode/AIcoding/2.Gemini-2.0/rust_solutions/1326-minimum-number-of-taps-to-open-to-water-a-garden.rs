impl Solution {
    pub fn min_taps(n: i32, ranges: Vec<i32>) -> i32 {
        let n = n as usize;
        let mut max_reach = vec![0; n + 1];
        for (i, &range) in ranges.iter().enumerate() {
            let start = std::cmp::max(0, i as i32 - range) as usize;
            let end = std::cmp::min(n, i + range as usize);
            max_reach[start] = std::cmp::max(max_reach[start], end);
        }

        let mut taps = 0;
        let mut current_reach = 0;
        let mut next_reach = 0;

        for i in 0..n {
            next_reach = std::cmp::max(next_reach, max_reach[i]);
            if i == current_reach {
                if i == next_reach {
                    return -1;
                }
                taps += 1;
                current_reach = next_reach;
            }
        }

        if current_reach < n {
            taps += 1;
        }

        taps
    }
}