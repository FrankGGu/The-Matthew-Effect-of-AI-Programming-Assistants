impl Solution {

use std::iter;

pub fn get_permutation(n: i32, k: i32) -> String {
    let mut numbers: Vec<char> = (1..=n).map(|i| (b'0' + i as u8) as char).collect();
    let mut k = k - 1;
    let mut result = String::with_capacity(n as usize);

    let mut factorial = 1;
    for i in 1..n {
        factorial *= i;
    }

    for i in 0..n {
        let index = k / factorial;
        k %= factorial;
        if i < n - 1 {
            factorial /= (n - 1 - i);
        }
        result.push(numbers.remove(index));
    }

    result
}
}