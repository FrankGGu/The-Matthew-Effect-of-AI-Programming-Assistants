use std::collections::HashSet;

impl Solution {
    pub fn distinct_integers(nums: Vec<i32>) -> i32 {
        let mut distinct_set: HashSet<i32> = HashSet::new();

        for &num in nums.iter() {
            distinct_set.insert(num);

            let mut reversed_num = 0;
            let mut temp_num = num;
            while temp_num > 0 {
                reversed_num = reversed_num * 10 + (temp_num % 10);
                temp_num /= 10;
            }
            distinct_set.insert(reversed_num);
        }

        distinct_set.len() as i32
    }
}