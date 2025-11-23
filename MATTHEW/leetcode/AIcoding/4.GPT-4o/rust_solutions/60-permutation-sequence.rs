impl Solution {
    pub fn get_permutation(n: i32, k: i32) -> String {
        let mut nums: Vec<char> = (1..=n).map(|x| (b'0' + x as u8) as char).collect();
        let mut k = k - 1;
        let mut factorials = vec![1; n as usize + 1];

        for i in 1..=n {
            factorials[i as usize] = factorials[(i - 1) as usize] * i;
        }

        let mut result = String::new();

        for i in (1..=n).rev() {
            let idx = (k / factorials[(i - 1) as usize]) as usize;
            result.push(nums.remove(idx));
            k %= factorials[(i - 1) as usize];
        }

        result
    }
}