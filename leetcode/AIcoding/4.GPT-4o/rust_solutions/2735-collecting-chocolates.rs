impl Solution {
    pub fn min_choco(choco: Vec<i32>, k: i32) -> i32 {
        let mut choco = choco;
        choco.sort_unstable();
        let n = choco.len();
        let mut result = 0;
        let mut count = 0;

        for i in (0..n).rev() {
            if count >= k {
                break;
            }
            result += choco[i];
            count += 1;
        }

        result
    }
}