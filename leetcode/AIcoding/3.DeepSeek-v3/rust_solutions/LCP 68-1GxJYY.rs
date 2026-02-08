impl Solution {
    pub fn beautiful_bouquet(flowers: Vec<i32>, cnt: i32) -> i32 {
        use std::collections::HashMap;
        let mut left = 0;
        let mut res = 0;
        let modulo = 1_000_000_007;
        let mut freq = HashMap::new();

        for right in 0..flowers.len() {
            *freq.entry(flowers[right]).or_insert(0) += 1;
            while *freq.get(&flowers[right]).unwrap() > cnt {
                *freq.get_mut(&flowers[left]).unwrap() -= 1;
                left += 1;
            }
            res = (res + (right - left + 1) as i32) % modulo;
        }
        res
    }
}