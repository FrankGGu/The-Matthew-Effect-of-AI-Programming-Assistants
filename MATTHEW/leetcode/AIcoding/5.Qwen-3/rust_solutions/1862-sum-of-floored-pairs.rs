impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn sum_of_floored_pairs(nums: Vec<i32>) -> i32 {
        let mut freq = HashMap::new();
        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
        }

        let max_num = *nums.iter().max().unwrap();
        let mut count = vec![0; (max_num + 1) as usize];

        for (&num, &cnt) in &freq {
            count[num as usize] = cnt;
        }

        let mut res = 0;
        for i in 1..=max_num {
            for j in 1..=max_num / i {
                let a = j * i;
                let b = (j + 1) * i - 1;
                let end = std::cmp::min(b, max_num);
                let total = count[a as usize..=end as usize].iter().sum::<i32>();
                res += total * (j as i32) * freq.get(&(i as i32)).copied().unwrap_or(0);
            }
        }

        res
    }
}
}