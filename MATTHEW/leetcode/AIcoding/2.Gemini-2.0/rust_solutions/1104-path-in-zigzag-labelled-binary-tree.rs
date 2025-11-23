impl Solution {
    pub fn path_in_zigzag_tree(label: i32) -> Vec<i32> {
        let mut level = 0;
        let mut pow2 = 1;
        while pow2 <= label {
            pow2 *= 2;
            level += 1;
        }
        level -= 1;

        let mut path = Vec::new();
        let mut current = label;

        while level >= 0 {
            path.push(current);

            let min = 1 << level;
            let max = (1 << (level + 1)) - 1;
            let parent = (min + max - current) / 2;

            current = parent;
            level -= 1;
        }

        path.reverse();
        path
    }
}