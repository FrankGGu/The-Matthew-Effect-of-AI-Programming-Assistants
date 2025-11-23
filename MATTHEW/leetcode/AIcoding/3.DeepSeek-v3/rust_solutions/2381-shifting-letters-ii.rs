impl Solution {
    pub fn shifting_letters(s: String, shifts: Vec<Vec<i32>>) -> String {
        let n = s.len();
        let mut diff = vec![0; n + 1];
        for shift in shifts {
            let (start, end, dir) = (shift[0] as usize, shift[1] as usize, shift[2]);
            let delta = if dir == 1 { 1 } else { -1 };
            diff[start] += delta;
            if end + 1 < n {
                diff[end + 1] -= delta;
            }
        }

        let mut res = Vec::with_capacity(n);
        let mut current_shift = 0;
        for (i, c) in s.chars().enumerate() {
            current_shift += diff[i];
            let shifted = ((c as i32 - 'a' as i32 + current_shift) % 26 + 26) % 26;
            res.push((shifted as u8 + b'a') as char);
        }

        res.into_iter().collect()
    }
}