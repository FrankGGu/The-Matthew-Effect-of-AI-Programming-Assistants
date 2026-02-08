impl Solution {
    pub fn permutation_sequence(n: i32, k: i32) -> String {
        let mut nums: Vec<i32> = (1..=n).collect();
        let mut factorial: Vec<i32> = vec![1; n as usize + 1];
        for i in 2..=n {
            factorial[i as usize] = factorial[(i - 1) as usize] * i;
        }

        let mut k = k - 1;
        let mut result = String::new();

        for i in (1..=n).rev() {
            let index = (k / factorial[(i - 1) as usize]) as usize;
            result.push_str(&nums.remove(index).to_string());
            k %= factorial[(i - 1) as usize];
        }

        result
    }
}

struct Solution;