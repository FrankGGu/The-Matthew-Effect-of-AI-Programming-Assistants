impl Solution {
    pub fn find_the_prefix_common_array(a: Vec<i32>, b: Vec<i32>) -> Vec<i32> {
        let mut common = vec![0; a.len()];
        let mut set_a = std::collections::HashSet::new();
        let mut set_b = std::collections::HashSet::new();
        let mut count = 0;

        for i in 0..a.len() {
            set_a.insert(a[i]);
            set_b.insert(b[i]);

            if set_a.contains(&b[i]) {
                count += 1;
            }
            if set_b.contains(&a[i]) && a[i] != b[i] {
                count += 1;
            }

            common[i] = count;
        }

        common
    }
}