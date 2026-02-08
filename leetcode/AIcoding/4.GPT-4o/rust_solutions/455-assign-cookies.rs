impl Solution {
    pub fn find_content_children(g: Vec<i32>, s: Vec<i32>) -> i32 {
        let mut g = g;
        let mut s = s;
        g.sort();
        s.sort();

        let mut child_i = 0;
        let mut cookie_i = 0;

        while child_i < g.len() && cookie_i < s.len() {
            if s[cookie_i] >= g[child_i] {
                child_i += 1;
            }
            cookie_i += 1;
        }

        child_i as i32
    }
}