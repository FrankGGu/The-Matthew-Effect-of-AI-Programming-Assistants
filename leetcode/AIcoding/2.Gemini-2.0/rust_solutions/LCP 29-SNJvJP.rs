impl Solution {
    pub fn orchestra_layout(num: i32, row: i32, col: i32) -> i32 {
        let n = num as i64;
        let r = row as i64;
        let c = col as i64;

        let mut layer = 0;
        let mut len = n;

        while r >= layer && r < n - layer && c >= layer && c < n - layer {
            if r == layer || r == n - layer - 1 || c == layer || c == n - layer - 1 {
                break;
            }
            layer += 1;
            len -= 2;
        }

        let start = layer;
        let end = n - layer - 1;
        let length = len;

        let mut ans = 0;

        if r == start {
            ans = c - start;
        } else if r == end {
            ans = 3 * length - (c - start);
        } else if c == start {
            ans = 4 * length - (r - start);
        } else {
            ans = length + (r - start);
        }

        let base = (num as i64 - length) / 2;
        ans += (base * (4 * n - 4 * base)) % 9;

        (ans % 9 + 1) as i32
    }
}