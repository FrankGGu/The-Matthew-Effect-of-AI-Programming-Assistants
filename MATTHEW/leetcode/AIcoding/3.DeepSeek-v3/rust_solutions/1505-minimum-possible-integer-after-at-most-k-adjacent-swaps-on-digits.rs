impl Solution {
    pub fn min_integer(num: String, k: i32) -> String {
        let mut num: Vec<char> = num.chars().collect();
        let mut k = k as usize;
        let n = num.len();
        let mut i = 0;

        while i < n && k > 0 {
            let mut min_pos = i;
            let max_pos = std::cmp::min(i + k, n - 1);

            for j in i + 1..=max_pos {
                if num[j] < num[min_pos] {
                    min_pos = j;
                }
            }

            let digit = num[min_pos];
            for j in (i..min_pos).rev() {
                num[j + 1] = num[j];
            }
            num[i] = digit;

            k -= min_pos - i;
            i += 1;
        }

        num.into_iter().collect()
    }
}