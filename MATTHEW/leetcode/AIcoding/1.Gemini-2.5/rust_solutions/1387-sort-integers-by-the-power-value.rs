impl Solution {
    pub fn get_kth(lo: i32, hi: i32, k: i32) -> i32 {
        let mut power_values: Vec<(i32, i32)> = Vec::new();

        for num in lo..=hi {
            let mut current = num;
            let mut steps = 0;
            while current != 1 {
                if current % 2 == 0 {
                    current /= 2;
                } else {
                    current = 3 * current + 1;
                }
                steps += 1;
            }
            power_values.push((steps, num));
        }

        power_values.sort_unstable();

        power_values[k as usize - 1].1
    }
}