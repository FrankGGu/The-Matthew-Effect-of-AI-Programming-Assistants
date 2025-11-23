impl Solution {
    pub fn longest_uploaded_prefix(n: i32, uploaded: Vec<i32>) -> i32 {
        let mut uploaded_set = std::collections::HashSet::new();
        for &x in &uploaded {
            uploaded_set.insert(x);
        }

        let mut prefix = 0;
        for i in 1..=n {
            if uploaded_set.contains(&i) {
                prefix += 1;
            } else {
                break;
            }
        }
        prefix
    }
}