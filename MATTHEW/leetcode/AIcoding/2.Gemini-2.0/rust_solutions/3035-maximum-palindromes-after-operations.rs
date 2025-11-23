impl Solution {
    pub fn max_palindromes_after_operations(s: String) -> i32 {
        let mut counts = vec![0; 26];
        for c in s.chars() {
            counts[(c as u8 - b'a') as usize] += 1;
        }

        let mut even_count = 0;
        for count in counts {
            even_count += count / 2;
        }

        let mut lengths: Vec<i32> = vec![];
        let mut current_length = 0;

        for sub in s.split(" ") {
            lengths.push(sub.len() as i32);
        }

        let mut chars_vec: Vec<char> = s.chars().collect();
        chars_vec.sort();

        lengths = s.split(" ").map(|x| x.len() as i32).collect();
        lengths.sort();
        lengths.reverse();

        let mut ans = 0;
        for length in lengths {
            if even_count >= length / 2 {
                even_count -= length / 2;
                ans += 1;
            }
        }

        ans
    }
}