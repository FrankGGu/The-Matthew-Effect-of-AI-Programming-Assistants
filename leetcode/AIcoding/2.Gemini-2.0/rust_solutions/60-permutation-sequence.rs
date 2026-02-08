impl Solution {
    pub fn get_permutation(n: i32, k: i32) -> String {
        let mut nums: Vec<i32> = (1..=n).collect();
        let mut factorial = vec![1; n as usize + 1];
        for i in 2..=n as usize {
            factorial[i] = factorial[i - 1] * i as i32;
        }

        let mut k = k - 1;
        let mut result = String::new();

        for i in (0..n).rev() {
            let index = (k / factorial[i as usize]) as usize;
            result.push_str(&nums.remove(index).to_string());
            k %= factorial[i as usize];
        }

        result
    }
}