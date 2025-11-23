impl Solution {
    pub fn find_content_children(mut g: Vec<i32>, mut s: Vec<i32>) -> i32 {
        g.sort();
        s.sort();

        let mut content_children = 0;
        let mut cookie_idx = 0;
        let mut child_idx = 0;

        while cookie_idx < s.len() && child_idx < g.len() {
            if s[cookie_idx] >= g[child_idx] {
                content_children += 1;
                child_idx += 1;
            }
            cookie_idx += 1;
        }

        content_children
    }
}