struct Solution;

impl Solution {
    pub fn str_without_3a3b(mut a: i32, mut b: i32) -> String {
        let mut result: Vec<char> = Vec::new();

        while a > 0 || b > 0 {
            let len = result.len();

            // Check if we can append 'a'
            // We can append 'a' if 'a' count is positive AND
            // (the string is too short to form "aa" or "bb" yet OR
            // the last two characters are NOT 'aa')
            let can_append_a = a > 0 && (len < 2 || !(result[len - 1] == 'a' && result[len - 2] == 'a'));

            // Check if we can append 'b'
            // We can append 'b' if 'b' count is positive AND
            // (the string is too short to form "aa" or "bb" yet OR
            // the last two characters are NOT 'bb')
            let can_append_b = b > 0 && (len < 2 || !(result[len - 1] == 'b' && result[len - 2] == 'b'));

            if can_append_a && can_append_b {
                // Both 'a' and 'b' can be appended.
                // Prioritize the character with a larger remaining count.
                // If counts are equal, 'a' is chosen (arbitrary but consistent).
                if a >= b {
                    result.push('a');
                    a -= 1;
                } else {
                    result.push('b');
                    b -= 1;
                }
            } else if can_append_a {
                // Only 'a' can be appended.
                result.push('a');
                a -= 1;
            } else if can_append_b {
                // Only 'b' can be appended.
                result.push('b');
                b -= 1;
            } else {
                // This case should not be reached given the problem constraints guarantee a solution.
                // It would imply that both 'a' and 'b' are blocked, and counts are still positive.
                // For example, if result ends in "aa" and b=0, and a>0, but a<=2.
                // Or if a=0 and b=0, the loop condition would already be false.
                break; 
            }
        }

        result.into_iter().collect()
    }
}