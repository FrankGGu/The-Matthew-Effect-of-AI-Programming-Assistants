impl Solution {
    pub fn min_operations(target: Vec<i32>, arr: Vec<i32>) -> i32 {
        use std::collections::HashMap;

        let mut target_map = HashMap::new();
        for (i, &num) in target.iter().enumerate() {
            target_map.insert(num, i);
        }

        let mut lis = Vec::new();
        for &num in arr.iter() {
            if let Some(&index) = target_map.get(&num) {
                if lis.is_empty() || index > *lis.last().unwrap() {
                    lis.push(index);
                } else {
                    let mut left = 0;
                    let mut right = lis.len() - 1;
                    while left < right {
                        let mid = left + (right - left) / 2;
                        if lis[mid] < index {
                            left = mid + 1;
                        } else {
                            right = mid;
                        }
                    }
                    lis[left] = index;
                }
            }
        }

        (target.len() - lis.len()) as i32
    }
}