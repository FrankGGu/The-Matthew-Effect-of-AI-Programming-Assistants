impl Solution {
    pub fn path_in_zigzag_tree(label: i32) -> Vec<i32> {
        let mut path = Vec::new();
        let mut level = 0;
        let mut node = label;

        while node > 1 {
            path.push(node);
            level += 1;
            node /= 2;
        }
        path.push(1);

        if level % 2 == 1 {
            for i in 0..path.len() {
                let max_label = (1 << (i + 1)) - 1;
                let min_label = 1 << i;
                path[i] = max_label - (path[i] - min_label);
            }
        }

        path.reverse();
        path
    }
}