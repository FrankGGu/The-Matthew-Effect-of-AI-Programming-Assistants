impl Solution {
    pub fn longest_substring(s: String, k: i32) -> i32 {
        let s_bytes = s.as_bytes();
        let n = s_bytes.len();

        if n == 0 || k > n as i32 {
            return 0;
        }
        if k <= 1 {
            return n as i32;
        }

        let mut counts = [0; 26];
        for &byte in s_bytes {
            counts[(byte - b'a') as usize] += 1;
        }

        for i in 0..n {
            let byte = s_bytes[i];
            if counts[(byte - b'a') as usize] < k {
                let mut left = String::from_utf8_lossy(&s_bytes[0..i]).to_string();
                let mut right = String::from_utf8_lossy(&s_bytes[i + 1..n]).to_string();

                return std::cmp::max(Solution::longest_substring(left, k), Solution::longest_substring(right, k));
            }
        }

        return n as i32;
    }
}