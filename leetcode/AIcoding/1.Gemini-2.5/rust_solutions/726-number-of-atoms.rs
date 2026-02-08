use std::collections::HashMap;

impl Solution {
    pub fn count_of_atoms(formula: String) -> String {
        let n = formula.len();
        let chars: Vec<char> = formula.chars().collect();
        let mut i = 0;

        let mut stack: Vec<HashMap<String, i32>> = vec![HashMap::new()];

        while i < n {
            match chars[i] {
                '(' => {
                    stack.push(HashMap::new());
                    i += 1;
                }
                ')' => {
                    i += 1;
                    let mut count_str = String::new();
                    while i < n && chars[i].is_ascii_digit() {
                        count_str.push(chars[i]);
                        i += 1;
                    }
                    let multiplier = if count_str.is_empty() {
                        1
                    } else {
                        count_str.parse::<i32>().unwrap()
                    };

                    let mut current_map = stack.pop().unwrap();
                    let prev_map = stack.last_mut().unwrap();

                    for (atom, count) in current_map.drain() {
                        *prev_map.entry(atom).or_insert(0) += count * multiplier;
                    }
                }
                _ => {
                    let mut atom_name = String::new();
                    atom_name.push(chars[i]);
                    i += 1;

                    while i < n && chars[i].is_ascii_lowercase() {
                        atom_name.push(chars[i]);
                        i += 1;
                    }

                    let mut count_str = String::new();
                    while i < n && chars[i].is_ascii_digit() {
                        count_str.push(chars[i]);
                        i += 1;
                    }
                    let count = if count_str.is_empty() {
                        1
                    } else {
                        count_str.parse::<i32>().unwrap()
                    };

                    let current_map = stack.last_mut().unwrap();
                    *current_map.entry(atom_name).or_insert(0) += count;
                }
            }
        }

        let final_map = stack.pop().unwrap();

        let mut atoms: Vec<String> = final_map.keys().cloned().collect();
        atoms.sort();

        let mut result = String::new();
        for atom in atoms {
            result.push_str(&atom);
            if let Some(&count) = final_map.get(&atom) {
                if count > 1 {
                    result.push_str(&count.to_string());
                }
            }
        }

        result
    }
}