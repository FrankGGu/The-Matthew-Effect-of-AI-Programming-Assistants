impl Solution {
    pub fn find_the_maximum_length(nums: Vec<i32>) -> i32 {
        let mut count = 0;
        let mut seen = std::collections::HashMap::new();

        for &num in &nums {
            if num == 1 {
                count += 1;
            } else {
                let mut found = false;
                for &key in seen.keys() {
                    if num % key == 0 {
                        let new_val = seen.get(&key).unwrap() + 1;
                        seen.insert(num, new_val);
                        found = true;
                        break;
                    }
                }
                if !found {
                    seen.insert(num, 1);
                }
            }
        }

        let mut max_len = 0;
        for &val in seen.values() {
            max_len = max_len.max(val);
        }

        count + max_len
    }
}