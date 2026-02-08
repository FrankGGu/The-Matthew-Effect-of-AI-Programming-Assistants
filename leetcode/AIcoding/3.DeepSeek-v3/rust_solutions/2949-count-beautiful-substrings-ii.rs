impl Solution {
    pub fn beautiful_substrings(s: String, k: i32) -> i64 {
        let s = s.chars().collect::<Vec<_>>();
        let n = s.len();
        let mut res = 0i64;
        let mut prefix = vec![0; n + 1];
        for i in 0..n {
            prefix[i + 1] = prefix[i] + if "aeiou".contains(s[i]) { 1 } else { 0 };
        }

        let m = (2 * k - 1).next_power_of_two();
        let mut freq = std::collections::HashMap::new();
        freq.insert((0, 0), 1);

        for i in 1..=n {
            let v = prefix[i];
            let c = i - prefix[i];
            let key = (v % k, (v - c) % (2 * k));
            res += *freq.get(&key).unwrap_or(&0);
            *freq.entry(key).or_insert(0) += 1;
        }

        res
    }
}