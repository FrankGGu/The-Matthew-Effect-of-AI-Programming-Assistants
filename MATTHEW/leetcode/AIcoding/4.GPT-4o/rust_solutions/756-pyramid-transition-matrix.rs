impl Solution {
    pub fn pyramid_transition(bottom: String, allowed: Vec<String>) -> bool {
        use std::collections::HashSet;

        let mut allowed_set = HashSet::new();
        for s in allowed {
            allowed_set.insert(s);
        }

        fn can_build_pyramid(current: &str, next: &mut Vec<char>, allowed_set: &HashSet<String>) -> bool {
            if current.len() == 1 {
                return true;
            }

            next.clear();
            let mut found = false;
            for i in 0..current.len() - 1 {
                let pair = format!("{}{}", current.chars().nth(i).unwrap(), current.chars().nth(i + 1).unwrap());
                if allowed_set.contains(&pair) {
                    for ch in allowed_set.iter().filter(|&&s| s.starts_with(&pair)) {
                        next.push(ch.chars().nth(2).unwrap());
                    }
                    found = true;
                }
            }
            if !found {
                return false;
            }

            let next_str: String = next.iter().collect();
            can_build_pyramid(&next_str, next, allowed_set)
        }

        let mut next = Vec::new();
        can_build_pyramid(&bottom, &mut next, &allowed_set)
    }
}