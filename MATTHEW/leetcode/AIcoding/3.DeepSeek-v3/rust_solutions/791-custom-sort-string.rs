impl Solution {
    pub fn custom_sort_string(order: String, s: String) -> String {
        let mut count = [0; 26];
        for c in s.chars() {
            count[(c as u8 - b'a') as usize] += 1;
        }

        let mut result = String::new();
        for c in order.chars() {
            let idx = (c as u8 - b'a') as usize;
            while count[idx] > 0 {
                result.push(c);
                count[idx] -= 1;
            }
        }

        for (i, &cnt) in count.iter().enumerate() {
            if cnt > 0 {
                let c = (i as u8 + b'a') as char;
                for _ in 0..cnt {
                    result.push(c);
                }
            }
        }

        result
    }
}