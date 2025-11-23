impl Solution {
    pub fn custom_sort_string(order: String, s: String) -> String {
        let mut count = [0; 26];
        let mut result = String::new();

        for ch in s.chars() {
            count[(ch as usize - 'a' as usize)] += 1;
        }

        for ch in order.chars() {
            let idx = (ch as usize - 'a' as usize);
            result.push_str(&ch.to_string().repeat(count[idx]));
            count[idx] = 0;
        }

        for i in 0..26 {
            if count[i] > 0 {
                result.push_str(&((b'a' + i as u8) as char).to_string().repeat(count[i]));
            }
        }

        result
    }
}