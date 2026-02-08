impl Solution {
    pub fn min_characters(a: String, b: String) -> i32 {
        let a_chars: Vec<char> = a.chars().collect();
        let b_chars: Vec<char> = a.chars().collect();
        let mut count_a = [0; 26];
        let mut count_b = [0; 26];

        for &c in &a_chars {
            count_a[(c as u8 - b'a') as usize] += 1;
        }

        for &c in &b_chars {
            count_b[(c as u8 - b'a') as usize] += 1;
        }

        let mut res = i32::MAX;

        for i in 0..26 {
            let c = ('a' as u8 + i as u8) as char;
            let total = a_chars.len() + b_chars.len() - count_a[i] - count_b[i];
            res = res.min(total as i32);
        }

        let mut prefix_a = [0; 27];
        let mut prefix_b = [0; 27];

        for i in 0..26 {
            prefix_a[i + 1] = prefix_a[i] + count_a[i];
            prefix_b[i + 1] = prefix_b[i] + count_b[i];
        }

        for i in 0..25 {
            let case1 = prefix_a[i + 1] + (prefix_b[26] - prefix_b[i + 1]);
            let case2 = prefix_b[i + 1] + (prefix_a[26] - prefix_a[i + 1]);
            res = res.min(case1.min(case2) as i32);
        }

        res
    }
}