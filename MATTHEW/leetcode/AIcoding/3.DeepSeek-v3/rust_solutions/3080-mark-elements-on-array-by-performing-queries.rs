use std::collections::HashSet;

struct Solution;

impl Solution {
    pub fn unmarked_sum_array(nums: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<i64> {
        let mut marked = HashSet::new();
        let mut sum: i64 = nums.iter().map(|&x| x as i64).sum();
        let mut unmarked: Vec<(i32, usize)> = nums.iter().enumerate()
            .map(|(i, &val)| (val, i))
            .collect();
        unmarked.sort();
        let mut res = Vec::new();
        let mut ptr = 0;
        for query in queries {
            let index = query[0] as usize;
            let k = query[1] as usize;
            if !marked.contains(&index) {
                marked.insert(index);
                sum -= nums[index] as i64;
            }
            let mut count = 0;
            while count < k && ptr < unmarked.len() {
                let (val, idx) = unmarked[ptr];
                if !marked.contains(&idx) {
                    marked.insert(idx);
                    sum -= val as i64;
                    count += 1;
                }
                ptr += 1;
            }
            res.push(sum);
        }
        res
    }
}