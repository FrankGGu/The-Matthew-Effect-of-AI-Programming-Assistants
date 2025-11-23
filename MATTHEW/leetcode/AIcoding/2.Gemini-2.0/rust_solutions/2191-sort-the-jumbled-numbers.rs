impl Solution {
    pub fn sort_jumbled(mapping: Vec<i32>, nums: Vec<i32>) -> Vec<i32> {
        let mut nums_with_mapped: Vec<(i32, i32)> = nums
            .into_iter()
            .map(|num| {
                let s = num.to_string();
                let mapped_str: String = s
                    .chars()
                    .map(|c| {
                        let digit = c.to_digit(10).unwrap() as usize;
                        mapping[digit].to_string()
                    })
                    .collect();
                let mapped_num = mapped_str.parse::<i32>().unwrap();
                (mapped_num, num)
            })
            .collect();

        nums_with_mapped.sort_by(|a, b| a.0.cmp(&b.0));

        nums_with_mapped.into_iter().map(|(_, num)| num).collect()
    }
}