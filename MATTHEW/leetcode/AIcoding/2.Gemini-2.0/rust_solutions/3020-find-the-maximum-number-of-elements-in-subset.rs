use std::collections::HashMap;

impl Solution {
    pub fn maximum_length(nums: Vec<i32>) -> i32 {
        let mut counts: HashMap<i32, i32> = HashMap::new();
        for &num in &nums {
            *counts.entry(num).or_insert(0) += 1;
        }

        let mut ans = 0;
        for (&start, &count) in &counts {
            if start == 1 {
                let mut curr = 1;
                let mut len = count;
                let mut next = curr * curr;
                while counts.contains_key(&next) {
                    if counts[&next] > 1 {
                        len += 2;
                    } else {
                        len += 1;
                    }
                    curr = next;
                    next = curr * curr;
                }
                ans = ans.max(len);
            } else if start > 1 {
                if counts.contains_key(&start) && counts[&start] > 0 {
                    let mut curr = start;
                    let mut len = 1;
                    let mut next = curr * curr;
                    while counts.contains_key(&next) {
                        if counts[&next] > 1 {
                            len += 2;
                        } else {
                            len += 1;
                        }
                        curr = next;
                        next = curr * curr;
                    }
                    ans = ans.max(len);
                }
            }
        }

        if ans % 2 == 0 {
            return ans - 1;
        }

        ans
    }
}