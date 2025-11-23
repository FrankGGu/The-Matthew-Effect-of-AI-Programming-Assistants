use std::collections::HashMap;

impl Solution {
    pub fn is_n_straight_hand(hand: Vec<i32>, group_size: i32) -> bool {
        let n = hand.len() as i32;
        let k = group_size;

        if n % k != 0 {
            return false;
        }

        let mut counts: HashMap<i32, i32> = HashMap::new();
        for &num in &hand {
            *counts.entry(num).or_insert(0) += 1;
        }

        let mut sorted_nums: Vec<i32> = hand.clone();
        sorted_nums.sort();

        for &num in &sorted_nums {
            if counts[&num] == 0 {
                continue;
            }

            *counts.get_mut(&num).unwrap() -= 1;
            for i in 1..k {
                let next_num = num + i;
                if counts.contains_key(&next_num) && counts[&next_num] > 0 {
                    *counts.get_mut(&next_num).unwrap() -= 1;
                } else {
                    return false;
                }
            }
        }

        true
    }
}