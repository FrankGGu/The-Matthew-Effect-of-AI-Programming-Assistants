use std::collections::HashSet;

impl Solution {
    pub fn pyramid_transition(bottom: String, allowed: Vec<String>) -> bool {
        let mut map: std::collections::HashMap<(char, char), Vec<char>> = std::collections::HashMap::new();
        for s in allowed {
            let chars: Vec<char> = s.chars().collect();
            map.entry((chars[0], chars[1])).or_insert(Vec::new()).push(chars[2]);
        }

        fn solve(current: String, map: &std::collections::HashMap<(char, char), Vec<char>>) -> bool {
            if current.len() == 1 {
                return true;
            }

            let mut next_levels: Vec<String> = Vec::new();
            let mut generate = |level: String| {
                if level.len() == current.len() - 1 {
                    next_levels.push(level);
                    return;
                }

                let i = level.len();
                let c1 = current.chars().nth(i).unwrap();
                let c2 = current.chars().nth(i + 1).unwrap();

                if let Some(next_chars) = map.get(&(c1, c2)) {
                    for &c in next_chars {
                        generate(level.clone() + &c.to_string());
                    }
                }
            };

            generate("".to_string());

            for next_level in next_levels {
                if solve(next_level, map) {
                    return true;
                }
            }

            false
        }

        solve(bottom, &map)
    }
}