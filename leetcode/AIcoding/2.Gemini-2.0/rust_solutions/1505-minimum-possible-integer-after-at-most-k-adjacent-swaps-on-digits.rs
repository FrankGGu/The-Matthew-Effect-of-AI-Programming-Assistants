impl Solution {
    pub fn min_integer(num: String, k: i32) -> String {
        let mut num_vec: Vec<usize> = num.chars().map(|c| c.to_digit(10).unwrap() as usize).collect();
        let n = num_vec.len();
        let mut k_usize = k as usize;
        let mut result = String::new();

        for i in 0..n {
            let mut min_idx = i;
            for j in (i + 1)..n {
                if num_vec[j] < num_vec[min_idx] {
                    min_idx = j;
                }
            }

            let dist = min_idx - i;

            if dist <= k_usize {
                k_usize -= dist;
                for j in (i..min_idx).rev() {
                    num_vec.swap(j, j + 1);
                }
            }
        }

        for digit in num_vec {
            result.push_str(&digit.to_string());
        }

        result
    }
}