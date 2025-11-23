impl Solution {
    pub fn count_binary_substrings(s: String) -> i32 {
        let mut groups = vec![];
        let mut current_group_len = 1;
        for i in 1..s.len() {
            if s.as_bytes()[i] == s.as_bytes()[i - 1] {
                current_group_len += 1;
            } else {
                groups.push(current_group_len);
                current_group_len = 1;
            }
        }
        groups.push(current_group_len);

        let mut count = 0;
        for i in 1..groups.len() {
            count += groups[i].min(groups[i - 1]);
        }

        count as i32
    }
}