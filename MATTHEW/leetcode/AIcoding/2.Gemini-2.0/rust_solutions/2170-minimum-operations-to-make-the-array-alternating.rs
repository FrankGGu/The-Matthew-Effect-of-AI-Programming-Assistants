impl Solution {
    pub fn minimum_operations(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n == 1 {
            return 0;
        }

        let mut even_counts = std::collections::HashMap::new();
        let mut odd_counts = std::collections::HashMap::new();

        for i in 0..n {
            if i % 2 == 0 {
                *even_counts.entry(nums[i]).or_insert(0) += 1;
            } else {
                *odd_counts.entry(nums[i]).or_insert(0) += 1;
            }
        }

        let mut even_vec: Vec<(&i32, &i32)> = even_counts.iter().collect();
        even_vec.sort_by(|a, b| b.1.cmp(a.1));

        let mut odd_vec: Vec<(&i32, &i32)> = odd_counts.iter().collect();
        odd_vec.sort_by(|a, b| b.1.cmp(a.1));

        if even_vec[0].0 != odd_vec[0].0 {
            return (n as i32) - even_vec[0].1 - odd_vec[0].1;
        } else {
            let even_max = even_vec[0].1;
            let odd_max = odd_vec[0].1;

            if even_vec.len() == 1 && odd_vec.len() == 1 {
                return n as i32 / 2;
            }

            if even_vec.len() == 1 {
                return (n as i32) - even_max - odd_vec[1].1;
            }

            if odd_vec.len() == 1 {
                return (n as i32) - even_vec[1].1 - odd_max;
            }

            return std::cmp::min(
                (n as i32) - even_max - odd_vec[1].1,
                (n as i32) - even_vec[1].1 - odd_max,
            );
        }
    }
}