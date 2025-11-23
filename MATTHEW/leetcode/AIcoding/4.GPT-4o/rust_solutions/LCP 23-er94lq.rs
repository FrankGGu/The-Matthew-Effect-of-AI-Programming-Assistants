impl Solution {
    pub fn get_permutation(n: i32, k: i32) -> String {
        let mut nums: Vec<i32> = (1..=n).collect();
        let mut fact: Vec<i32> = vec![1; (n + 1) as usize];

        for i in 2..=n {
            fact[i as usize] = fact[(i - 1) as usize] * i;
        }

        let mut k = k - 1;
        let mut result = String::new();

        for i in (1..=n).rev() {
            let idx = (k / fact[i as usize - 1]) as usize;
            result.push_str(&nums[idx].to_string());
            nums.remove(idx);
            k %= fact[i as usize - 1];
        }

        result
    }
}