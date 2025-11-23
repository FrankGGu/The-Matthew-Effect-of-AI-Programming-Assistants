impl Solution {
    pub fn adventure_camp(expeditions: Vec<String>) -> i32 {
        use std::collections::HashSet;

        let mut max_new = 0;
        let mut result = -1;
        let mut seen = HashSet::new();

        for (i, exp) in expeditions.iter().enumerate() {
            let current: HashSet<_> = exp.split("->").map(|s| s.trim()).filter(|&s| !s.is_empty()).collect();
            let new_count = current.difference(&seen).count();

            if new_count > max_new || (new_count == max_new && i < result as usize) {
                max_new = new_count;
                result = i as i32;
            }

            seen.extend(current);
        }

        if max_new == 0 {
            -1
        } else {
            result
        }
    }
}