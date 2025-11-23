impl Solution {
    pub fn palindromic_queries(s: String, queries: Vec<Vec<i32>>) -> Vec<bool> {
        let mut count = [0; 26];
        let mut odd_count = 0;

        for c in s.chars() {
            let idx = (c as u8 - b'a') as usize;
            count[idx] += 1;
            if count[idx] % 2 == 1 {
                odd_count += 1;
            } else {
                odd_count -= 1;
            }
        }

        queries.into_iter().map(|query| {
            let (l, r) = (query[0] as usize, query[1] as usize);
            let mut temp_count = [0; 26];
            let mut temp_odd_count = 0;

            for i in l..=r {
                let idx = (s.as_bytes()[i] - b'a') as usize;
                temp_count[idx] += 1;
                if temp_count[idx] % 2 == 1 {
                    temp_odd_count += 1;
                } else {
                    temp_odd_count -= 1;
                }
            }

            temp_odd_count <= 1
        }).collect()
    }
}