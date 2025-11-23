use std::collections::BTreeMap;

impl Solution {
    pub fn delete_and_earn(nums: Vec<i32>) -> i32 {
        let mut count = BTreeMap::new();
        for &num in &nums {
            *count.entry(num).or_insert(0) += num;
        }

        let mut prev = 0;
        let mut curr = 0;
        let mut prev_num = -1;

        for (&num, &sum) in count.iter() {
            if prev_num == num - 1 {
                let temp = curr;
                curr = curr.max(prev + sum);
                prev = temp;
            } else {
                prev = curr;
                curr += sum;
            }
            prev_num = num;
        }

        curr
    }
}