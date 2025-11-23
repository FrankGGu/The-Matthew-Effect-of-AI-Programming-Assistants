impl Solution {
    pub fn beauty_sum(s: String) -> i32 {
        let bytes = s.as_bytes();
        let n = bytes.len();
        let mut total_beauty = 0;

        for i in 0..n {
            let mut count = [0; 26];
            for j in i..n {
                count[(bytes[j] - b'a') as usize] += 1;
                let non_zero_counts: Vec<_> = count.iter().filter(|&&x| x > 0).collect();
                if non_zero_counts.len() > 1 {
                    let min = *non_zero_counts.iter().min().unwrap();
                    let max = *non_zero_counts.iter().max().unwrap();
                    total_beauty += max - min;
                }
            }
        }
        total_beauty
    }
}