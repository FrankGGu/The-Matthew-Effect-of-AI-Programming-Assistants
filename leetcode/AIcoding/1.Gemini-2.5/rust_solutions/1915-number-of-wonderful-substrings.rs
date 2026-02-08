impl Solution {
    pub fn wonderful_substrings(word: String) -> i64 {
        let mut ans: i64 = 0;
        let mut freq: Vec<i64> = vec![0; 1 << 10]; 

        freq[0] = 1; 
        let mut current_mask: i32 = 0;

        for ch in word.chars() {
            let char_idx = (ch as u8 - b'a') as i32;
            current_mask ^= (1 << char_idx); 

            ans += freq[current_mask as usize];

            for k in 0..10 {
                let target_mask = current_mask ^ (1 << k);
                ans += freq[target_mask as usize];
            }

            freq[current_mask as usize] += 1;
        }

        ans
    }
}