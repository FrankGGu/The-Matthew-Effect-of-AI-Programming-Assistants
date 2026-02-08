struct Solution;

impl Solution {
    pub fn min_insertions(s: String) -> i32 {
        let mut open_needed = 0;
        let mut insertions = 0;
        let mut chars = s.chars().peekable();

        while let Some(c) = chars.next() {
            if c == '(' {
                open_needed += 1;
            } else { // c == ')'
                if open_needed > 0 {
                    // This ')' can potentially match an open '('.
                    // Check if there's a second ')' immediately after.
                    if chars.peek() == Some(&')') {
                        chars.next(); // Consume the second ')'
                        open_needed -= 1; // Matched one '(' with '))'
                    } else {
                        // Only one ')' found, need to insert another ')'
                        insertions += 1;
                        open_needed -= 1; // Matched one '(' with ')' and an inserted ')'
                    }
                } else {
                    // No open '(' to match this ')'.
                    // We must insert an opening '('
                    insertions += 1;
                    // Now we effectively have an inserted '(' followed by this ')'.
                    // This ')' acts as the first ')' for the inserted '('.
                    // Check if there's a second ')' immediately after.
                    if chars.peek() == Some(&')') {
                        chars.next(); // Consume the second ')'
                        // The inserted '(' is now balanced by these two ')'
                    } else {
                        // Only one ')' found, need to insert another ')'
                        insertions += 1;
                        // The inserted '(' is now balanced by this ')' and an inserted ')'
                    }
                }
            }
        }

        // After iterating, any remaining open '(' need two ')' each.
        insertions += open_needed * 2;

        insertions
    }
}