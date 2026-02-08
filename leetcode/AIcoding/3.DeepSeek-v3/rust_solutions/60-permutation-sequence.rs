impl Solution {
    pub fn get_permutation(n: i32, k: i32) -> String {
        let n = n as usize;
        let mut k = k as usize - 1;
        let mut numbers: Vec<usize> = (1..=n).collect();
        let mut factorial = vec![1; n];
        for i in 1..n {
            factorial[i] = factorial[i - 1] * i;
        }

        let mut result = String::new();
        for i in (0..n).rev() {
            let index = k / factorial[i];
            result.push_str(&numbers[index].to_string());
            numbers.remove(index);
            k %= factorial[i];
        }

        result
    }
}