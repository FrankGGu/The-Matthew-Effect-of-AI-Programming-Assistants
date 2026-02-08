use std::collections::HashMap;

impl Solution {
    pub fn pyramid_transition(bottom: String, allowed: Vec<String>) -> bool {
        let mut map: HashMap<(char, char), Vec<char>> = HashMap::new();
        for s in allowed {
            let chars: Vec<char> = s.chars().collect();
            let (a, b, c) = (chars[0], chars[1], chars[2]);
            map.entry((a, b)).or_insert_with(Vec::new).push(c);
        }
        Self::dfs(&bottom.chars().collect(), &map)
    }

    fn dfs(current: &Vec<char>, map: &HashMap<(char, char), Vec<char>>) -> bool {
        if current.len() == 1 {
            return true;
        }
        let mut next_level = Vec::new();
        for i in 0..current.len() - 1 {
            let key = (current[i], current[i + 1]);
            if !map.contains_key(&key) {
                return false;
            }
            next_level.push(map.get(&key).unwrap());
        }
        Self::generate_combinations(&next_level, 0, &mut Vec::new(), map)
    }

    fn generate_combinations(
        levels: &Vec<&Vec<char>>,
        index: usize,
        current: &mut Vec<char>,
        map: &HashMap<(char, char), Vec<char>>,
    ) -> bool {
        if index == levels.len() {
            return Self::dfs(current, map);
        }
        for &c in levels[index].iter() {
            current.push(c);
            if Self::generate_combinations(levels, index + 1, current, map) {
                return true;
            }
            current.pop();
        }
        false
    }
}