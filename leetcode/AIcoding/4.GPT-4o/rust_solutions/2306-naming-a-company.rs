impl Solution {
    pub fn distinct_names(ideas: Vec<String>) -> i32 {
        let mut set = std::collections::HashSet::new();
        let mut count = 0;

        for idea in &ideas {
            set.insert(idea.clone());
        }

        for i in 0..ideas.len() {
            for j in 0..ideas.len() {
                if i != j {
                    let new_name = format!("{}{}", ideas[i].chars().next().unwrap(), &ideas[j][1..]);
                    if !set.contains(&new_name) {
                        count += 1;
                    }
                }
            }
        }

        count / 2
    }
}