struct Solution;

impl Solution {
    pub fn find_content_children(mut g: Vec<i32>, mut s: Vec<i32>) -> i32 {
        g.sort_unstable();
        s.sort_unstable();

        let mut child_idx: usize = 0;
        let mut cookie_idx: usize = 0;
        let mut content_children: i32 = 0;

        while child_idx < g.len() && cookie_idx < s.len() {
            if s[cookie_idx] >= g[child_idx] {
                content_children += 1;
                child_idx += 1;
            }
            cookie_idx += 1;
        }

        content_children
    }
}