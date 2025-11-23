impl Solution {
    pub fn find_key(numbers: Vec<i32>, target: i32) -> i32 {
        let mut map = std::collections::HashMap::new();
        for &num in &numbers {
            *map.entry(num).or_insert(0) += 1;
        }
        for &num in &numbers {
            if let Some(&count) = map.get(&(target - num)) {
                if target - num == num && count < 2 {
                    continue;
                }
                return num;
            }
        }
        -1
    }
}