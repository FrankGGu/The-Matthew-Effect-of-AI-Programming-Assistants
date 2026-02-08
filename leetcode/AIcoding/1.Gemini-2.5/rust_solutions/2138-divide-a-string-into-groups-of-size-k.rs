impl Solution {
    pub fn divide_string(s: String, k: i32, fill: char) -> Vec<String> {
        let n = s.len();
        let k_usize = k as usize;
        let mut result: Vec<String> = Vec::new();

        let mut temp_s = s; 

        let remainder = n % k_usize;
        if remainder != 0 {
            let needed_padding = k_usize - remainder;
            for _ in 0..needed_padding {
                temp_s.push(fill);
            }
        }

        let final_len = temp_s.len();
        for i in (0..final_len).step_by(k_usize) {
            let group = &temp_s[i..(i + k_usize)];
            result.push(group.to_string());
        }

        result
    }
}