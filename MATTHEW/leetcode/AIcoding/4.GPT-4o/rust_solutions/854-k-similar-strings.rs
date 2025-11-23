use std::collections::HashSet;

pub fn k_similarity(a: String, b: String) -> i32 {
    fn bfs(a: String, b: String) -> i32 {
        let mut queue = std::collections::VecDeque::new();
        let mut visited = HashSet::new();
        queue.push_back((a, 0));
        visited.insert(a.clone());

        while let Some((current, steps)) = queue.pop_front() {
            if current == b {
                return steps;
            }
            let mut chars: Vec<char> = current.chars().collect();
            let len = chars.len();

            for i in 0..len {
                if chars[i] != b.chars().nth(i).unwrap() {
                    for j in i + 1..len {
                        if chars[j] == b.chars().nth(i).unwrap() && chars[j] != b.chars().nth(j).unwrap() {
                            chars.swap(i, j);
                            let new_str: String = chars.iter().collect();
                            if visited.insert(new_str.clone()) {
                                queue.push_back((new_str, steps + 1));
                            }
                            chars.swap(i, j);
                        }
                    }
                    break;
                }
            }
        }
        0
    }

    bfs(a, b)
}