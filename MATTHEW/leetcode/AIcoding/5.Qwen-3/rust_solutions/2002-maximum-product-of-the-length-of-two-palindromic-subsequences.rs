impl Solution {
    pub fn max_palindrome_product(s: String) -> i32 {
        use std::collections::HashMap;

        fn get_palindromic_subsequences(s: &str) -> HashMap<String, usize> {
            let n = s.len();
            let mut map = HashMap::new();
            for mask in 1..(1 << n) {
                let mut subseq = String::new();
                for i in 0..n {
                    if mask & (1 << i) != 0 {
                        subseq.push(s.chars().nth(i).unwrap());
                    }
                }
                if is_palindrome(&subseq) {
                    map.entry(subseq.clone()).or_insert(0);
                    *map.get_mut(&subseq).unwrap() += 1;
                }
            }
            map
        }

        fn is_palindrome(s: &str) -> bool {
            let chars: Vec<char> = s.chars().collect();
            let n = chars.len();
            for i in 0..n / 2 {
                if chars[i] != chars[n - 1 - i] {
                    return false;
                }
            }
            true
        }

        let n = s.len();
        let palindromes = get_palindromic_subsequences(&s);

        let mut max_product = 0;
        let keys: Vec<&String> = palindromes.keys().collect();

        for i in 0..keys.len() {
            for j in i + 1..keys.len() {
                let len_i = keys[i].len();
                let len_j = keys[j].len();
                if len_i * len_j > max_product {
                    max_product = len_i * len_j;
                }
            }
        }

        max_product as i32
    }
}