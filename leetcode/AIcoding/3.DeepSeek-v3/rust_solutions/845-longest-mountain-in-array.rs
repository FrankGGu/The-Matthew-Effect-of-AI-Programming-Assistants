impl Solution {
    pub fn longest_mountain(a: Vec<i32>) -> i32 {
        let n = a.len();
        if n < 3 {
            return 0;
        }
        let mut res = 0;
        let mut up = vec![0; n];
        let mut down = vec![0; n];

        for i in (0..n-1).rev() {
            if a[i] > a[i+1] {
                down[i] = down[i+1] + 1;
            }
        }

        for i in 1..n {
            if a[i] > a[i-1] {
                up[i] = up[i-1] + 1;
            }
            if up[i] > 0 && down[i] > 0 {
                res = res.max(up[i] + down[i] + 1);
            }
        }

        if res >= 3 { res } else { 0 }
    }
}