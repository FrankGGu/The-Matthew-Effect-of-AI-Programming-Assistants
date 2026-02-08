impl Solution {
    pub fn min_insertions(s: String) -> i32 {
        let mut balance = 0;
        let mut insertions = 0;
        let mut i = 0;

        while i < s.len() {
            match s.chars().nth(i).unwrap() {
                '(' => {
                    balance += 1;
                    i += 1;
                }
                ')' => {
                    if i + 1 < s.len() && s.chars().nth(i + 1).unwrap() == ')' {
                        if balance > 0 {
                            balance -= 1;
                        } else {
                            insertions += 1;
                        }
                        i += 2;
                    } else {
                        if balance > 0 {
                            balance -= 1;
                            insertions += 1;
                        } else {
                            insertions += 2;
                        }
                        i += 1;
                    }
                }
                _ => i += 1,
            }
        }

        insertions + balance * 2
    }
}