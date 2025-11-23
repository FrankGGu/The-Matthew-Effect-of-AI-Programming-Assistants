impl Solution {
    pub fn smallest_trimmed_numbers(nums: Vec<String>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut res = Vec::new();
        for query in queries {
            let k = query[0] as usize;
            let trim = query[1] as usize;
            let mut trimmed: Vec<(String, usize)> = nums.iter().enumerate().map(|(i, num)| {
                let start = if num.len() > trim { num.len() - trim } else { 0 };
                (num[start..].to_string(), i)
            }).collect();
            trimmed.sort();
            res.push(trimmed[k - 1].1 as i32);
        }
        res
    }
}