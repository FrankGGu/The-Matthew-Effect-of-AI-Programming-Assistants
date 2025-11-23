impl Solution {
    pub fn can_transform(start: String, end: String) -> bool {
        if start.chars().filter(|&c| c != 'X').collect::<String>() != end.chars().filter(|&c| c != 'X').collect::<String>() {
            return false;
        }

        let mut i = 0;
        let mut j = 0;

        while i < start.len() && j < end.len() {
            while i < start.len() && start.chars().nth(i).unwrap() == 'X' {
                i += 1;
            }
            while j < end.len() && end.chars().nth(j).unwrap() == 'X' {
                j += 1;
            }

            if i < start.len() && j < end.len() {
                if start.chars().nth(i).unwrap() != end.chars().nth(j).unwrap() {
                    return false;
                }

                if start.chars().nth(i).unwrap() == 'L' {
                    if i < j {
                        return false;
                    }
                } else if start.chars().nth(i).unwrap() == 'R' {
                    if i > j {
                        return false;
                    }
                }

                i += 1;
                j += 1;
            }
        }

        return true;
    }
}