impl Solution {
    pub fn min_moves_to_make_palindrome(s: String) -> i32 {
        let mut count = vec![0; 26];
        let mut odd_count = 0;

        for ch in s.chars() {
            count[(ch as usize) - ('a' as usize)] += 1;
        }

        for &c in &count {
            if c % 2 == 1 {
                odd_count += 1;
            }
        }

        let n = s.len();
        if odd_count > 1 {
            return -1;
        }

        let mut moves = 0;
        let mut chars: Vec<char> = s.chars().collect();

        while chars.len() > 1 {
            let last = chars.len() - 1;
            if chars[0] == chars[last] {
                chars.remove(0);
                chars.remove(last - 1);
            } else {
                let mut i = 1;
                while i < chars.len() && chars[i] != chars[last] {
                    i += 1;
                }
                if i < chars.len() {
                    for j in (0..i).rev() {
                        chars.remove(j);
                        moves += 1;
                    }
                    chars.remove(last - 1);
                } else {
                    return -1;
                }
            }
        }
        moves
    }
}