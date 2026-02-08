impl Solution {
    pub fn max_groups_for_increasing_length(n: i32) -> i32 {
        let mut n_remaining = n;
        let mut groups = 0;
        let mut required_for_next_group = 1;

        while n_remaining >= required_for_next_group {
            n_remaining -= required_for_next_group;
            groups += 1;
            required_for_next_group += 1;
        }

        groups
    }
}