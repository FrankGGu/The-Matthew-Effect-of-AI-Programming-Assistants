impl Solution {
    pub fn count_excellent_pairs(nums: Vec<i32>, k: i32) -> i64 {
        use std::collections::HashSet;

        let mut set = HashSet::new();
        for &num in &nums {
            set.insert(num);
        }

        let mut counts = vec![0; 32];
        for &num in &set {
            let mut count = 0;
            let mut temp = num;
            while temp > 0 {
                if temp & 1 == 1 {
                    count += 1;
                }
                temp >>= 1;
            }
            counts[count as usize] += 1;
        }

        let mut result = 0;
        for i in 0..32 {
            if counts[i] > 0 {
                for j in 0..32 {
                    if counts[j] > 0 && i + j >= k as usize {
                        result += counts[i] as i64 * counts[j] as i64;
                    }
                }
            }
        }

        result
    }
}