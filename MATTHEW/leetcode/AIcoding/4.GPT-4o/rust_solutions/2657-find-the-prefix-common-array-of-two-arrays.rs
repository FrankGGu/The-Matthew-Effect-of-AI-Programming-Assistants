impl Solution {
    pub fn find_the_prefix_common_array(A: Vec<i32>, B: Vec<i32>) -> Vec<i32> {
        let mut prefix_common = Vec::new();
        let mut count_a = 0;
        let mut count_b = 0;
        let mut seen_a = std::collections::HashSet::new();
        let mut seen_b = std::collections::HashSet::new();

        for i in 0..A.len() {
            seen_a.insert(A[i]);
            seen_b.insert(B[i]);
            count_a = seen_a.len() as i32;
            count_b = seen_b.len() as i32;
            prefix_common.push(count_a.min(count_b));
        }

        prefix_common
    }
}