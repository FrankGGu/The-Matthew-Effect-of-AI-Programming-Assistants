impl Solution {
    pub fn min_partition(s: String) -> i32 {
        let mut count = [0; 26];
        let mut total = 0;

        for &c in s.as_bytes() {
            count[(c - b'a') as usize] += 1;
            total += 1;
        }

        let mut min_parts = total;

        for i in 1..=total {
            let mut valid = true;
            for &c in count.iter() {
                if c > 0 && c % i != 0 {
                    valid = false;
                    break;
                }
            }
            if valid {
                min_parts = min_parts.min(i);
            }
        }

        min_parts as i32
    }
}