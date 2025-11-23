impl Solution {
    pub fn path_in_zig_zag_tree(label: i32) -> Vec<i32> {
        let mut level = 0;
        let mut label = label;
        while (1 << level) <= label {
            level += 1;
        }
        let mut res = vec![];
        while label >= 1 {
            res.push(label);
            let level_start = 1 << (level - 1);
            let level_end = (1 << level) - 1;
            label = (level_start + level_end - label) / 2;
            level -= 1;
        }
        res.reverse();
        res
    }
}