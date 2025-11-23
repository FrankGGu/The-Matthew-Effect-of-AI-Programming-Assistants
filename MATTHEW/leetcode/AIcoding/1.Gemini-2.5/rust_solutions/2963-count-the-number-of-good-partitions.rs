use std::collections::HashMap;

impl Solution {
    pub fn count_good_partitions(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n == 0 {
            return 0;
        }

        let mut last_occurrence: HashMap<i32, usize> = HashMap::new();
        for (i, &num) in nums.iter().enumerate() {
            last_occurrence.insert(num, i);
        }

        let mut num_blocks = 0;
        let mut current_max_reach = 0; 

        let MOD: i64 = 1_000_000_007;

        for i in 0..n {
            current_max_reach = current_max_reach.max(*last_occurrence.get(&nums[i]).unwrap());

            if i == current_max_reach {
                num_blocks += 1;
            }
        }

        Self::power(2, (num_blocks - 1) as i64, MOD) as i32
    }

    fn power(mut base: i64, mut exp: i64, modulus: i64) -> i64 {
        let mut res = 1;
        base %= modulus;
        while exp > 0 {
            if exp % 2 == 1 {
                res = (res * base) % modulus;
            }
            base = (base * base) % modulus;
            exp /= 2;
        }
        res
    }
}