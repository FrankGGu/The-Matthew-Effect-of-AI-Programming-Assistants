impl Solution {
    pub fn max_cost(s: String, chars: String, vals: Vec<i32>) -> i32 {
        let mut value = vec![0; 26];
        for i in 0..26 {
            value[i] = i as i32 - 96 + 1;
        }

        for i in 0..chars.len() {
            value[(chars.as_bytes()[i] - b'a') as usize] = vals[i];
        }

        let mut max_so_far = 0;
        let mut current_max = 0;

        for &c in s.as_bytes() {
            let char_value = value[(c - b'a') as usize];
            current_max += char_value;

            if current_max < 0 {
                current_max = 0;
            }

            max_so_far = max_so_far.max(current_max);
        }

        max_so_far
    }
}