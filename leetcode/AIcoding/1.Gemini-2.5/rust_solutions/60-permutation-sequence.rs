impl Solution {
    pub fn get_permutation(n: i32, k: i32) -> String {
        let mut k = k - 1;

        let mut factorials: Vec<i32> = vec![1; n as usize + 1];
        for i in 1..=n as usize {
            factorials[i] = factorials[i - 1] * i as i32;
        }

        let mut numbers: Vec<char> = (1..=n).map(|x| (x as u8 + b'0') as char).collect();
        let mut result = String::with_capacity(n as usize);

        for i in (1..=n).rev() {
            let fact = factorials[i as usize - 1];
            let index = (k / fact) as usize;

            result.push(numbers.remove(index));
            k %= fact;
        }

        result
    }
}