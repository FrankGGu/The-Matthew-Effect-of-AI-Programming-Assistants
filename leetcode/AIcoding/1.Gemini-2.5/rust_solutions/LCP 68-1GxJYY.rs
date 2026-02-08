use std::collections::HashMap;

impl Solution {
    pub fn beautiful_bouquet(flowers: Vec<i32>, cnt: i32) -> i64 {
        let n = flowers.len();
        let mut left = 0;
        let mut ans: i64 = 0;
        let mut freq: HashMap<i32, i32> = HashMap::new();

        for right in 0..n {
            *freq.entry(flowers[right]).or_insert(0) += 1;

            while *freq.get(&flowers[right]).unwrap() > cnt {
                *freq.entry(flowers[left]).or_insert(0) -= 1;
                left += 1;
            }
            ans += (right - left + 1) as i64;
        }

        ans
    }
}