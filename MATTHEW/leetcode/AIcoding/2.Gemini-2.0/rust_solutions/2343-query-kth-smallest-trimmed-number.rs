impl Solution {
    pub fn smallest_trimmed_numbers(nums: Vec<String>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut result = Vec::new();
        for query in queries {
            let k = query[0] as usize;
            let trim = query[1] as usize;
            let mut trimmed_nums: Vec<(String, usize)> = nums
                .iter()
                .enumerate()
                .map(|(i, num)| {
                    let len = num.len();
                    (num[len - trim..].to_string(), i)
                })
                .collect();

            trimmed_nums.sort_by(|a, b| {
                if a.0 == b.0 {
                    a.1.cmp(&b.1)
                } else {
                    a.0.cmp(&b.0)
                }
            });

            result.push(trimmed_nums[k - 1].1 as i32);
        }
        result
    }
}