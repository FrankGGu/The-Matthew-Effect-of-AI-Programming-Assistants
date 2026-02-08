impl Solution {
    pub fn longest_equal_subarray(arr: Vec<i32>, k: i32) -> i32 {
        let mut count = std::collections::HashMap::new();
        let mut max_len = 0;
        let mut left = 0;
        let mut max_count = 0;

        for right in 0..arr.len() {
            *count.entry(arr[right]).or_insert(0) += 1;
            max_count = max_count.max(*count.get(&arr[right]).unwrap());

            while right - left + 1 - max_count > k {
                *count.get_mut(&arr[left]).unwrap() -= 1;
                if *count.get(&arr[left]).unwrap() == 0 {
                    count.remove(&arr[left]);
                }
                left += 1;
            }

            max_len = max_len.max(right - left + 1);
        }

        max_len
    }
}