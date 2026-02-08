impl Solution {
    pub fn find_the_prefix_common_array(a: Vec<i32>, b: Vec<i32>) -> Vec<i32> {
        let n = a.len();
        let mut result = Vec::new();
        for i in 0..n {
            let mut count = 0;
            let mut a_prefix = a[0..=i].to_vec();
            let mut b_prefix = b[0..=i].to_vec();

            let mut seen = std::collections::HashSet::new();

            for &val in &a_prefix {
                seen.insert(val);
            }

            for &val in &b_prefix {
                if seen.contains(&val) {
                    count += 1;
                }
            }

            result.push(count);
        }
        result
    }
}