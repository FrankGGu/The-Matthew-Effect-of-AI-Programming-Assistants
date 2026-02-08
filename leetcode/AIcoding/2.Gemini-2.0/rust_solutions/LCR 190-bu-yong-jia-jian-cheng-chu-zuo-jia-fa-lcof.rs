impl Solution {
    pub fn get_value(s: String, m: &Vec<i32>) -> i32 {
        let mut res = 0;
        for c in s.chars() {
            res = res * 10 + m[(c as u8 - b'a') as usize];
        }
        res
    }

    pub fn is_valid(word1: &String, word2: &String, result: &String, m: &Vec<i32>) -> bool {
        if (word1.len() > 1 && m[(word1.as_bytes()[0] - b'a') as usize] == 0) ||
           (word2.len() > 1 && m[(word2.as_bytes()[0] - b'a') as usize] == 0) ||
           (result.len() > 1 && m[(result.as_bytes()[0] - b'a') as usize] == 0) {
            return false;
        }
        Solution::get_value(word1.clone(), m) + Solution::get_value(word2.clone(), m) == Solution::get_value(result.clone(), m)
    }

    pub fn is_solvable(words: Vec<String>, result: String) -> bool {
        let mut chars: Vec<char> = Vec::new();
        for word in &words {
            for c in word.chars() {
                if !chars.contains(&c) {
                    chars.push(c);
                }
            }
        }
        for c in result.chars() {
            if !chars.contains(&c) {
                chars.push(c);
            }
        }

        let mut m: Vec<i32> = vec![-1; 26];
        let mut used: Vec<bool> = vec![false; 10];

        Solution::backtrack(&words, &result, &chars, 0, &mut m, &mut used)
    }

    fn backtrack(words: &Vec<String>, result: &String, chars: &Vec<char>, idx: usize, m: &mut Vec<i32>, used: &mut Vec<bool>) -> bool {
        if idx == chars.len() {
            return Solution::is_valid(
                &words[0],
                &words[1],
                result,
                m,
            );
        }

        for i in 0..10 {
            if !used[i] {
                m[(chars[idx] as u8 - b'a') as usize] = i as i32;
                used[i] = true;

                if Solution::backtrack(words, result, chars, idx + 1, m, used) {
                    return true;
                }

                used[i] = false;
                m[(chars[idx] as u8 - b'a') as usize] = -1;
            }
        }

        return false;
    }
}