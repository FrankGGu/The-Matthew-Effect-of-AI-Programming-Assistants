impl Solution {
    pub fn maximize_active_section(sat: Vec<i32>, k: i32) -> i32 {
        let n = sat.len();
        let mut diffs: Vec<i32> = vec![0; n];
        for i in 0..n {
            diffs[i] = sat[i] - (i as i32 + 1);
        }
        diffs.sort();
        let mut ans = 0;
        for i in 0..n {
            ans += sat[i];
        }
        for i in 0..k.min(n as i32) as usize {
            ans -= diffs[i];
        }
        ans
    }
}