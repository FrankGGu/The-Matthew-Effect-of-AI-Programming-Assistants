impl Solution {
    pub fn maximum_swap(num: i32) -> i32 {
        let mut digits: Vec<char> = num.to_string().chars().collect();
        let n = digits.len();
        let mut max_indices = vec![0; n];
        max_indices[n - 1] = n - 1;

        for i in (0..n - 1).rev() {
            if digits[i] > digits[max_indices[i + 1]] {
                max_indices[i] = i;
            } else {
                max_indices[i] = max_indices[i + 1];
            }
        }

        for i in 0..n {
            if digits[i] != digits[max_indices[i]] {
                digits.swap(i, max_indices[i]);
                break;
            }
        }

        digits.into_iter().collect::<String>().parse().unwrap()
    }
}