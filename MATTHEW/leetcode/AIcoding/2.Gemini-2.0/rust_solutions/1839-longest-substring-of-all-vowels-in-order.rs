impl Solution {
    pub fn longest_beautiful_substring(word: String) -> i32 {
        let s: Vec<char> = word.chars().collect();
        let n = s.len();
        let mut ans = 0;
        for i in 0..n {
            let mut j = i;
            let mut vowels = vec![false; 5];
            let mut count = 0;
            while j < n {
                if count == 0 {
                    if s[j] == 'a' {
                        vowels[0] = true;
                        count += 1;
                    } else {
                        break;
                    }
                } else {
                    let prev = match s[j - 1] {
                        'a' => 0,
                        'e' => 1,
                        'i' => 2,
                        'o' => 3,
                        'u' => 4,
                        _ => unreachable!(),
                    };
                    let curr = match s[j] {
                        'a' => 0,
                        'e' => 1,
                        'i' => 2,
                        'o' => 3,
                        'u' => 4,
                        _ => unreachable!(),
                    };
                    if curr >= prev {
                        vowels[curr] = true;
                        count += 1;
                    } else {
                        break;
                    }
                }
                j += 1;
            }
            if vowels.iter().all(|&x| x) {
                ans = ans.max(count as i32);
            }
        }
        ans
    }
}