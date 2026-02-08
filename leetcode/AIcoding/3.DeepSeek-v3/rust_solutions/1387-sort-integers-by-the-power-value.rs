use std::collections::HashMap;

impl Solution {
    pub fn get_kth(lo: i32, hi: i32, k: i32) -> i32 {
        let mut memo = HashMap::new();
        memo.insert(1, 0);

        fn power(x: i32, memo: &mut HashMap<i32, i32>) -> i32 {
            if let Some(&p) = memo.get(&x) {
                return p;
            }
            let next = if x % 2 == 0 { x / 2 } else { 3 * x + 1 };
            let p = 1 + power(next, memo);
            memo.insert(x, p);
            p
        }

        let mut nums: Vec<_> = (lo..=hi).map(|x| (x, power(x, &mut memo))).collect();
        nums.sort_by_key(|&(x, p)| (p, x));
        nums[k as usize - 1].0
    }
}