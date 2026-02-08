impl Solution {
    pub fn smallest_trimmed_numbers(nums: Vec<String>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut results = Vec::new();

        for query in queries {
            let (k, trim) = (query[0] as usize, query[1] as usize);
            let mut trimmed: Vec<(String, usize)> = nums.iter()
                .enumerate()
                .map(|(i, num)| {
                    let trimmed_num = num[num.len() - trim..].to_string();
                    (trimmed_num, i)
                })
                .collect();

            trimmed.sort();
            results.push(trimmed[k - 1].1 as i32);
        }

        results
    }
}