struct Solution;

impl Solution {
    pub fn path_in_zigzag_tree(label: i32) -> Vec<i32> {
        let mut curr = label;
        let mut path = Vec::new();

        while curr >= 1 {
            path.push(curr);
            if curr == 1 {
                break;
            }

            let level = (32 - (curr as u32).leading_zeros()) as i32;

            let min_curr_level = 1 << (level - 1);
            let max_curr_level = (1 << level) - 1;

            let parent_level = level - 1;
            let min_parent_level = 1 << (parent_level - 1);
            let max_parent_level = (1 << parent_level) - 1;

            let normal_parent_value;
            if level % 2 == 1 {
                normal_parent_value = curr / 2;
            } else {
                let normal_curr_value = min_curr_level + (max_curr_level - curr);
                normal_parent_value = normal_curr_value / 2;
            }

            if parent_level % 2 == 1 {
                curr = normal_parent_value;
            } else {
                curr = min_parent_level + (max_parent_level - normal_parent_value);
            }
        }

        path.reverse();
        path
    }
}