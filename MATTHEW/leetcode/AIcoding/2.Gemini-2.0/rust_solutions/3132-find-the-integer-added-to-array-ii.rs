impl Solution {
    pub fn find_the_integer_added_to_array(changed: Vec<i32>, threshold: i32) -> i32 {
        let mut counts = std::collections::HashMap::new();
        for &num in &changed {
            *counts.entry(num).or_insert(0) += 1;
        }

        let mut added = Vec::new();
        for &num in &changed {
            if counts[&num] > 0 {
                *counts.get_mut(&num).unwrap() -= 1;
                let doubled = num * 2;
                if counts.contains_key(&doubled) && counts[&doubled] > 0 {
                    *counts.get_mut(&doubled).unwrap() -= 1;
                } else {
                    added.push(num);
                }
            }
        }

        if added.is_empty() {
            return 0;
        }

        let sum: i64 = added.iter().map(|&x| x as i64).sum();
        if sum as i32 > threshold {
            return -1;
        }

        *added.iter().min().unwrap_or(&0)
    }
}