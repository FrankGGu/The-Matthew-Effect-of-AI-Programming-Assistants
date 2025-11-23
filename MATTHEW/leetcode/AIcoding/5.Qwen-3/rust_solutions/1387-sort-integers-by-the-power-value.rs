impl Solution {

use std::cmp::Ordering;
use std::collections::BTreeMap;

impl Solution {
    pub fn sort_by_quietness(mut nums: Vec<i32>) -> Vec<i32> {
        let mut map = BTreeMap::new();

        for &num in &nums {
            let power = Self::get_power(num);
            map.entry(power).or_insert_with(Vec::new).push(num);
        }

        let mut result = Vec::new();
        for (_, values) in map {
            result.extend(values);
        }

        result
    }

    fn get_power(mut num: i32) -> i32 {
        let mut steps = 0;
        while num != 1 {
            if num % 2 == 0 {
                num /= 2;
            } else {
                num = 3 * num + 1;
            }
            steps += 1;
        }
        steps
    }
}
}