impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn numberof_ways(young: i32, children: i32, bikes: i32) -> i32 {
        let mut memo = HashMap::new();
        Self::dp(0, 0, young, children, bikes, &mut memo)
    }

    fn dp(index: usize, count: i32, young: i32, children: i32, bikes: i32, memo: &mut HashMap<(usize, i32), i32>) -> i32 {
        if count == young {
            return 1;
        }
        if index >= (children + bikes) as usize {
            return 0;
        }
        let key = (index, count);
        if let Some(&val) = memo.get(&key) {
            return val;
        }
        let mut res = 0;
        if count < young {
            res += Self::dp(index + 1, count + 1, young, children, bikes, memo);
        }
        res += Self::dp(index + 1, count, young, children, bikes, memo);
        memo.insert(key, res);
        res
    }
}
}