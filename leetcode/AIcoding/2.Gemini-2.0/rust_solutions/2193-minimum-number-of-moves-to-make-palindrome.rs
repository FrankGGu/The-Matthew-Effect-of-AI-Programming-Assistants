impl Solution {
    pub fn min_moves_to_make_palindrome(s: String) -> i32 {
        let mut chars: Vec<char> = s.chars().collect();
        let mut moves = 0;

        for i in 0..chars.len() / 2 {
            let mut j = chars.len() - 1 - i;
            while chars[i] != chars[j] {
                j -= 1;
            }

            if i == j {
                moves += chars.len() / 2 - i;
                continue;
            }

            for k in j..chars.len() - 1 - i {
                chars.swap(k, k + 1);
                moves += 1;
            }
        }

        moves
    }
}