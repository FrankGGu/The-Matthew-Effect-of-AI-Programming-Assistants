impl Solution {
    pub fn custom_sort_string(order: String, s: String) -> String {
        let mut counts = [0; 26];

        for c in s.chars() {
            counts[(c as u8 - b'a') as usize] += 1;
        }

        let mut result = String::with_capacity(s.len());

        for c_order in order.chars() {
            let index = (c_order as u8 - b'a') as usize;
            let count = counts[index];
            for _ in 0..count {
                result.push(c_order);
            }
            counts[index] = 0;
        }

        for i in 0..26 {
            let c_s = (b'a' + i as u8) as char;
            let count = counts[i];
            for _ in 0..count {
                result.push(c_s);
            }
        }

        result
    }
}