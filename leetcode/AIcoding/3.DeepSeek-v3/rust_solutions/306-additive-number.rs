impl Solution {
    pub fn is_additive_number(num: String) -> bool {
        let n = num.len();
        if n < 3 {
            return false;
        }
        let num_bytes = num.as_bytes();
        for i in 1..=n / 2 {
            for j in 1..=(n - i) / 2 {
                let first = &num[..i];
                let second = &num[i..i + j];
                if (first.len() > 1 && first.starts_with('0')) || (second.len() > 1 && second.starts_with('0')) {
                    continue;
                }
                let mut a = first.parse::<u64>().unwrap();
                let mut b = second.parse::<u64>().unwrap();
                let mut k = i + j;
                let mut remaining = num_bytes[k..].to_vec();
                while !remaining.is_empty() {
                    let sum = a + b;
                    let sum_str = sum.to_string();
                    if remaining.starts_with(sum_str.as_bytes()) {
                        k += sum_str.len();
                        remaining = num_bytes[k..].to_vec();
                        a = b;
                        b = sum;
                    } else {
                        break;
                    }
                }
                if k == n {
                    return true;
                }
            }
        }
        false
    }
}