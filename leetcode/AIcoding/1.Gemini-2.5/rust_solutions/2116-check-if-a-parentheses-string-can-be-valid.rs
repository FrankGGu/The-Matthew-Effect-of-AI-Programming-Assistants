impl Solution {
    pub fn can_be_valid(s: String, locked: String) -> bool {
        let n = s.len();
        if n % 2 != 0 {
            return false;
        }

        let s_chars: Vec<char> = s.chars().collect();
        let locked_chars: Vec<char> = locked.chars().collect();

        // Pass 1: Left to Right
        // min_balance: tracks the minimum possible balance (assuming '0's are ')' when possible)
        // max_balance: tracks the maximum possible balance (assuming '0's are '(' when possible)
        let mut min_balance = 0;
        let mut max_balance = 0;

        for i in 0..n {
            if locked_chars[i] == '1' {
                if s_chars[i] == '(' {
                    min_balance += 1;
                    max_balance += 1;
                } else { // s_chars[i] == ')'
                    min_balance -= 1;
                    max_balance -= 1;
                }
            } else { // locked_chars[i] == '0' (can be '(' or ')')
                min_balance -= 1; // Assume ')' to get the minimum possible balance
                max_balance += 1; // Assume '(' to get the maximum possible balance
            }

            min_balance = min_balance.max(0); // Balance cannot go below 0
            if max_balance < 0 { // Even if all '0's are used as '(', balance is negative
                return false;
            }
        }

        if min_balance != 0 { // At the end, minimum balance must be 0
            return false;
        }

        // Pass 2: Right to Left
        // min_balance (from right): tracks the minimum possible balance of closing parentheses
        // max_balance (from right): tracks the maximum possible balance of closing parentheses
        min_balance = 0;
        max_balance = 0;

        for i in (0..n).rev() {
            if locked_chars[i] == '1' {
                if s_chars[i] == ')' {
                    min_balance += 1;
                    max_balance += 1;
                } else { // s_chars[i] == '('
                    min_balance -= 1;
                    max_balance -= 1;
                }
            } else { // locked_chars[i] == '0'
                min_balance -= 1; // Assume '(' to get the minimum possible balance (from right)
                max_balance += 1; // Assume ')' to get the maximum possible balance (from right)
            }

            min_balance = min_balance.max(0); // Balance cannot go below 0
            if max_balance < 0 { // Even if all '0's are used as ')', balance is negative
                return false;
            }
        }

        if min_balance != 0 { // At the end, minimum balance must be 0
            return false;
        }

        true
    }
}