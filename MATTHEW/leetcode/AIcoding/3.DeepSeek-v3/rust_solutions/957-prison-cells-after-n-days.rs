impl Solution {
    pub fn prison_after_n_days(cells: Vec<i32>, n: i32) -> Vec<i32> {
        let mut seen = std::collections::HashMap::new();
        let mut current = cells.clone();
        let mut remaining = n;

        while remaining > 0 {
            let key = current.clone();
            if let Some(&prev_day) = seen.get(&key) {
                let cycle_length = prev_day - remaining;
                remaining %= cycle_length;
                if remaining == 0 {
                    break;
                }
            } else {
                seen.insert(key, remaining);
            }

            let mut next = vec![0; 8];
            for i in 1..7 {
                next[i] = if current[i - 1] == current[i + 1] { 1 } else { 0 };
            }
            current = next;
            remaining -= 1;
        }

        current
    }
}