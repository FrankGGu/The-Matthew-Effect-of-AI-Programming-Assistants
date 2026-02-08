impl Solution {
    pub fn shifting_letters(s: String, shifts: Vec<Vec<i32>>) -> String {
        let n = s.len();
        let mut char_vals: Vec<u8> = s.bytes().map(|b| b - b'a').collect();
        let mut net_shifts: Vec<i32> = vec![0; n];

        for shift in shifts {
            let start = shift[0] as usize;
            let end = shift[1] as usize;
            let direction = shift[2];

            let value = if direction == 1 { 1 } else { -1 };

            net_shifts[start] += value;
            if end + 1 < n {
                net_shifts[end + 1] -= value;
            }
        }

        for i in 1..n {
            net_shifts[i] += net_shifts[i - 1];
        }

        for i in 0..n {
            let current_char_val = char_vals[i] as i32;
            let total_shift = net_shifts[i];

            let new_char_val = (current_char_val + total_shift).rem_euclid(26);
            char_vals[i] = new_char_val as u8;
        }

        char_vals.into_iter().map(|b| (b + b'a') as char).collect()
    }
}