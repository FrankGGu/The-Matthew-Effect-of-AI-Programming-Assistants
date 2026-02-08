impl Solution {
    pub fn max_vowels(s: String, k: i32) -> i32 {
        let vowels = "aeiou";
        let mut max_count = 0;
        let mut current_count = 0;
        let k = k as usize;

        for (i, c) in s.chars().enumerate() {
            if vowels.contains(c) {
                current_count += 1;
            }
            if i >= k {
                if vowels.contains(s.chars().nth(i - k).unwrap()) {
                    current_count -= 1;
                }
            }
            if i >= k - 1 {
                max_count = max_count.max(current_count);
            }
        }

        max_count
    }
}