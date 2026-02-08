impl Solution {
    pub fn min_characters(a: String, b: String) -> i32 {
        let n = a.len();
        let m = b.len();
        let a_chars: Vec<char> = a.chars().collect();
        let b_chars: Vec<char> = b.chars().collect();

        let mut ans = i32::MAX;

        for c in 'a' as u8..='z' as u8 {
            let mut count1 = 0;
            for &ch in &a_chars {
                if ch as u8 >= c {
                    count1 += 1;
                }
            }
            for &ch in &b_chars {
                if ch as u8 < c {
                    count1 += 1;
                }
            }
            ans = ans.min(count1);

            let mut count2 = 0;
            for &ch in &b_chars {
                if ch as u8 >= c {
                    count2 += 1;
                }
            }
            for &ch in &a_chars {
                if ch as u8 < c {
                    count2 += 1;
                }
            }
            ans = ans.min(count2);
        }

        let mut count3 = 0;
        let mut freq_a = vec![0; 26];
        let mut freq_b = vec![0; 26];

        for &ch in &a_chars {
            freq_a[(ch as u8 - 'a' as u8) as usize] += 1;
        }
        for &ch in &b_chars {
            freq_b[(ch as u8 - 'a' as u8) as usize] += 1;
        }

        for i in 0..26 {
            count3 = count3.max(freq_a[i].max(freq_b[i]));
        }

        ans.min((n + m - count3) as i32) as i32
    }
}