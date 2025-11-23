impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn maximum_total_reward(head: Option<Box<ListNode>>) -> i32 {
        let mut values = vec![];
        let mut current = head;
        while let Some(node) = current {
            values.push(node.val);
            current = node.next;
        }

        values.sort();
        let mut unique_values: HashSet<i32> = values.into_iter().collect();
        let mut dp = std::collections::BTreeSet::new();
        dp.insert(0);

        for val in unique_values {
            let mut new_dp = dp.clone();
            for &prev in &dp {
                if prev < val {
                    new_dp.insert(prev + val);
                }
            }
            dp = new_dp;
        }

        *dp.iter().next_back().unwrap()
    }
}

pub struct ListNode {
    pub val: i32,
    pub next: Option<Box<ListNode>>,
}

pub struct Solution;
}